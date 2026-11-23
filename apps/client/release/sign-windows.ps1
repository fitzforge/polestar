# Authenticode-signs one file for `tauri build`: bundle.windows.signCommand in
# src-tauri/tauri.windows-sign.conf.json, which .github/workflows/client.yml merges only when the
# release environment has the four ES_* secrets. Tauri calls it for the app's .exe (before it goes
# into the installer) and for the .msi. The key stays in SSL.com's cloud HSM (eSigner); SSL.com's
# CodeSignTool (unpacked at CODESIGNTOOL_DIR by the workflow) signs and timestamps through it.
param([Parameter(Mandatory)][string]$File)

$ErrorActionPreference = 'Stop'

# Tauri also offers the WiX toolset's own extension DLLs, which only run during the build and are
# not ours to sign: leave them as WiX ships them.
if ((Split-Path -Leaf $File) -match '^Wix\w*Extension\.dll$') {
	Write-Host "Not signing $File (WiX build tool)"
	exit 0
}

foreach ($name in 'CODESIGNTOOL_DIR', 'ES_USERNAME', 'ES_PASSWORD', 'ES_CREDENTIAL_ID', 'ES_TOTP_SECRET') {
	if (-not [Environment]::GetEnvironmentVariable($name)) { throw "$name is not set" }
}

# CodeSignTool reads its settings from conf/ under the current directory.
Push-Location $env:CODESIGNTOOL_DIR
try {
	& java -jar 'jar/code_sign_tool-1.3.2.jar' sign `
		"-username=$env:ES_USERNAME" "-password=$env:ES_PASSWORD" `
		"-credential_id=$env:ES_CREDENTIAL_ID" "-totp_secret=$env:ES_TOTP_SECRET" `
		'-program_name=Polestar Client' "-input_file_path=$File" -override
	if ($LASTEXITCODE -ne 0) { throw "CodeSignTool exited with $LASTEXITCODE on $File" }
} finally {
	Pop-Location
}

# CodeSignTool can report an error and still exit 0: trust only the signature itself.
$sig = Get-AuthenticodeSignature -FilePath $File
if ($sig.Status -ne 'Valid') { throw "$File is not validly signed: $($sig.Status). $($sig.StatusMessage)" }
Write-Host "Signed $File ($($sig.SignerCertificate.Subject))"
