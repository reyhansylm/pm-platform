FROM golang:1.19-alpine AS builder

FROM heroiclabs/nakama:latest

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=5 CMD curl -f http://localhost:7350/ || exit 1

ENV DBUSER=XpXrJRpmN4VtdVxv
ENV DBPASS=VW6Luv0pzFFcV8wdW1kd
ENV DBHOST=dei-db.cpm3thjmhwox.eu-central-1.rds.amazonaws.com

EXPOSE 7349
EXPOSE 7350
EXPOSE 7351

ENTRYPOINT [ "/bin/sh", "-ecx", "/nakama/nakama migrate up --database.address ${DBUSER}:${DBPASS}@${DBHOST}:5432/platform && exec /nakama/nakama --config /nakama/data/local.yml --database.address ${DBUSER}:${DBPASS}@${DBHOST}:5432/platform"]

COPY bin/index /nakama/data/modules/
COPY local.yml /nakama/data/
