# Build Stage:
FROM golang:1.18 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

## Add Source Code
ADD . /pulsarctl
WORKDIR /pulsarctl

## Build Step
RUN go mod download
RUN make pulsarctl

# Package Stage
FROM debian:bookworm-slim
COPY --from=builder /pulsarctl/bin/pulsarctl /