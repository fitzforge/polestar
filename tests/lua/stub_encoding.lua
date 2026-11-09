-- C_EncodingUtil for tests: DecodeBase64 and DecompressString (zlib), in plain
-- Lua 5.1 (no bit library), so Polestar_Nav's walking maps decode the way the
-- client decodes them. Inflate follows RFC 1950/1951 (puff's canonical
-- Huffman decoding); the Adler-32 trailer is not checked.

local byte, char, concat, floor, min, unpack = string.byte, string.char, table.concat, math.floor, math.min, unpack

local B64 = {}
do
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, 64 do
		B64[byte(alphabet, i)] = i - 1
	end
end

local function decodeBase64(s)
	local out, n, value, bits = {}, 0, 0, 0
	for i = 1, #s do
		local c = byte(s, i)
		local v = B64[c]
		if v then
			value, bits = value * 64 + v, bits + 6
			if bits >= 8 then
				bits = bits - 8
				local b = floor(value / 2 ^ bits)
				value = value - b * 2 ^ bits
				n = n + 1
				out[n] = b
			end
		elseif c ~= 61 then
			return nil
		end
	end
	local parts = {}
	for i = 1, n, 4096 do
		parts[#parts + 1] = char(unpack(out, i, min(i + 4095, n)))
	end
	return concat(parts)
end

local LBASE = { 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258 }
local LEXT = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0 }
local DBASE = { 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577 }
local DEXT = { 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13 }
local ORDER = { 16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15 }

-- lengths[0..n-1] -> { count[len], symbol[0-based] }
local function huffman(lengths, n)
	local count, offs, symbol = {}, {}, {}
	for len = 0, 15 do
		count[len] = 0
	end
	for s = 0, n - 1 do
		local len = lengths[s] or 0
		count[len] = count[len] + 1
	end
	offs[1] = 0
	for len = 1, 14 do
		offs[len + 1] = offs[len] + count[len]
	end
	for s = 0, n - 1 do
		local len = lengths[s] or 0
		if len ~= 0 then
			symbol[offs[len]] = s
			offs[len] = offs[len] + 1
		end
	end
	return { count = count, symbol = symbol }
end

local FIXED_LIT, FIXED_DIST
do
	local l = {}
	for s = 0, 143 do l[s] = 8 end
	for s = 144, 255 do l[s] = 9 end
	for s = 256, 279 do l[s] = 7 end
	for s = 280, 287 do l[s] = 8 end
	FIXED_LIT = huffman(l, 288)
	local d = {}
	for s = 0, 29 do d[s] = 5 end
	FIXED_DIST = huffman(d, 30)
end

local function inflate(data)
	local pos, buf, cnt = 3, 0, 0 -- past the two-byte zlib header
	local out, n = {}, 0

	local function bits(k)
		while cnt < k do
			local b = byte(data, pos)
			if not b then error("inflate: truncated", 0) end
			buf, cnt, pos = buf + b * 2 ^ cnt, cnt + 8, pos + 1
		end
		local p = 2 ^ k
		local v = buf % p
		buf, cnt = (buf - v) / p, cnt - k
		return v
	end

	local function decode(h)
		local code, first, index = 0, 0, 0
		local count, symbol = h.count, h.symbol
		for len = 1, 15 do
			code = code + bits(1)
			local c = count[len]
			if code - c < first then return symbol[index + code - first] end
			index, first, code = index + c, (first + c) * 2, code * 2
		end
		error("inflate: bad code", 0)
	end

	local function codes(lit, dist)
		while true do
			local s = decode(lit)
			if s < 256 then
				n = n + 1
				out[n] = s
			elseif s == 256 then
				return
			else
				s = s - 256
				local len = LBASE[s] + bits(LEXT[s])
				local d = decode(dist) + 1
				local back = DBASE[d] + bits(DEXT[d])
				for _ = 1, len do
					n = n + 1
					out[n] = out[n - back]
				end
			end
		end
	end

	repeat
		local last = bits(1)
		local kind = bits(2)
		if kind == 0 then
			buf, cnt = 0, 0
			local lo, hi = byte(data, pos, pos + 1)
			local len = lo + hi * 256
			pos = pos + 4
			for i = 0, len - 1 do
				n = n + 1
				out[n] = byte(data, pos + i)
			end
			pos = pos + len
		elseif kind == 1 then
			codes(FIXED_LIT, FIXED_DIST)
		elseif kind == 2 then
			local nlen, ndist, ncode = bits(5) + 257, bits(5) + 1, bits(4) + 4
			local lengths = {}
			for i = 1, 19 do lengths[ORDER[i]] = i <= ncode and bits(3) or 0 end
			local lencode = huffman(lengths, 19)
			local all, i = {}, 0
			while i < nlen + ndist do
				local s = decode(lencode)
				if s < 16 then
					all[i], i = s, i + 1
				else
					local value, rep = 0, 0
					if s == 16 then
						value, rep = all[i - 1], 3 + bits(2)
					elseif s == 17 then
						rep = 3 + bits(3)
					else
						rep = 11 + bits(7)
					end
					for _ = 1, rep do
						all[i], i = value, i + 1
					end
				end
			end
			local lit, dist = {}, {}
			for s = 0, nlen - 1 do lit[s] = all[s] end
			for s = 0, ndist - 1 do dist[s] = all[nlen + s] end
			codes(huffman(lit, nlen), huffman(dist, ndist))
		else
			error("inflate: bad block type", 0)
		end
	until last == 1

	local parts = {}
	for i = 1, n, 4096 do
		parts[#parts + 1] = char(unpack(out, i, min(i + 4095, n)))
	end
	return concat(parts)
end

stub.decompressed = 0 -- DecompressString calls, for tests that count decoding

C_EncodingUtil = C_EncodingUtil or {}
C_EncodingUtil.DecodeBase64 = decodeBase64
function C_EncodingUtil.DecompressString(s)
	stub.decompressed = stub.decompressed + 1
	local ok, raw = pcall(inflate, s)
	return ok and raw or nil
end
Enum.CompressionMethod.Zlib = Enum.CompressionMethod.Zlib or 1
