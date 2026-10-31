# The bug bot: Node's own WebSocket and fetch, no npm dependencies.
# Pinned by digest (the multi-arch index of node:24.22.1-alpine); bump both together.
FROM node:24.22.1-alpine@sha256:06d7adf3e0ef61a13f1d28682726366f97a15aa1888c934d3ecec86c33918b53
WORKDIR /app
COPY bot.js notify.js ./
COPY lib ./lib
USER node
CMD ["node", "bot.js"]
