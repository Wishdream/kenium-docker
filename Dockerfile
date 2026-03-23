FROM oven/bun:alpine

WORKDIR /usr/src/app

COPY --chown=bun:bun . .
COPY --chown=bun:bun docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p /usr/src/app/data && chown -R bun:bun /usr/src/app/data

RUN bun install
USER bun

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bun", "run", "index.ts"]
