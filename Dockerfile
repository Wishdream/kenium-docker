FROM node:24-alpine

WORKDIR /usr/src/app

# Install pnpm globally
RUN npm install -g pnpm

# Copy Kenium source (from GitHub Actions or local context)
COPY . .

# Copy entrypoint and make executable (must be done as root)
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Add non-root user and change ownership
RUN addgroup kenium && adduser -S -G kenium kenium
RUN chown -R kenium:kenium /usr/src/app

USER kenium

# Ensure local binaries (tsx, etc.) are on PATH
ENV PATH="/usr/src/app/node_modules/.bin:$PATH"

# Install dependencies as non-root user
RUN pnpm install --no-frozen-lockfile

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["pnpm", "run", "startNode"]
