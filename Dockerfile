FROM gcr.io/cloud-builders/go AS build-env

WORKDIR /app
COPY . .

RUN apk add git
RUN git config --global url."https://cnydevelop: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 @github.com".insteadOf "https://github.com"

RUN go get -v
RUN go build main.go

FROM alpine:latest

RUN apk add --no-cache ca-certificates

COPY --from=build-env /app/main /app/main

ENTRYPOINT [ "/app/main" ]
