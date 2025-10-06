FROM node:24-alpine

WORKDIR /usr/src/app

# Install pnpm and dependencies
RUN npm install -g pnpm
COPY . .
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN pnpm install --no-frozen-lockfile

# Setup PNPM_HOME for global binaries
ENV PNPM_HOME=/usr/local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH
RUN mkdir -p $PNPM_HOME && pnpm add -g tsx

# Set create non-root user and set ownership
RUN addgroup kenium && adduser -S -G kenium kenium
RUN chown -R kenium:kenium /usr/src/app

# Switch to non-root
USER kenium

# PATH for local binaries
ENV PATH="/usr/src/app/node_modules/.bin:$PATH"

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["pnpm", "run", "startNode"]
