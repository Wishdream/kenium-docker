FROM oven/bun:alpine

WORKDIR /usr/src/app

COPY . .
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN bun install

RUN chown -R bun:bun /usr/src/app
USER bun

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bun", "run", "startBun"]
