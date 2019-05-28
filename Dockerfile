FROM golang:latest AS builder
RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o _output/bin/vault_exporter
FROM scratch
COPY --from=builder /app/_output/bin/vault_exporter .
ENTRYPOINT ["./vault_exporter"]
