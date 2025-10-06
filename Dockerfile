FROM node:20-alpine

WORKDIR /usr/src/app

# Install pnpm
RUN npm install -g pnpm

# Copy Kenium source (provided by GitHub Actions before build)
COPY . .

# Install dependencies
RUN pnpm install --no-frozen-lockfile

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Security: run as non-root user
RUN addgroup kenium && adduser -S -G kenium kenium
USER kenium

# Change ownership of the app directory to non-root user
RUN chown -R kenium:kenium /usr/src/app

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["pnpm", "startNode"]
