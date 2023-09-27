FROM heroiclabs/nakama-pluginbuilder:latest AS go-builder

ENV GO111MODULE on
ENV CGO_ENABLED 1

WORKDIR /backend

COPY go.mod .
COPY main.go .
COPY vendor/ vendor/
COPY src/ src/

RUN go build --trimpath --mod=vendor --buildmode=plugin -o ./build/backend.so

FROM heroiclabs/nakama:latest

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=5 CMD curl -f http://localhost:7350/ || exit 1

ENV DBUSER=postgres
ENV DBPASS=secret
ENV DBHOST=172.17.0.1

EXPOSE 7349
EXPOSE 7350
EXPOSE 7351

ENTRYPOINT [ "/bin/sh", "-ecx", "/nakama/nakama migrate up --database.address ${DBUSER}:${DBPASS}@${DBHOST}:5432/platform && exec /nakama/nakama --config /nakama/data/local.yml --database.address ${DBUSER}:${DBPASS}@${DBHOST}:5432/platform"]

COPY --from=go-builder /backend/build/backend.so /nakama/data/modules/
COPY local.yml /nakama/data/