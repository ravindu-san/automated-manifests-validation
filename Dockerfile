# multistage build

# stage 1
# install binaries
FROM alpine AS binary-builder
RUN mkdir -p /binaries
RUN apk add --no-cache curl \
    unzip

RUN curl -L -o /binaries/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64


#stage 2
# action image
FROM ubuntu:18.04
COPY --from=binary-builder /binaries/opa /usr/local/bin
RUN chmod 755 /usr/local/bin/opa
RUN opa version
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["opa version"]