FROM alpine/helm:latest

RUN apk --no-cache add git
RUN helm plugin install https://github.com/chartmuseum/helm-push

ADD fmlabs.xyz.crt /usr/local/share/ca-certificates/fmlabs.xyz.crt
RUN chmod 644 /usr/local/share/ca-certificates/fmlabs.xyz.crt
RUN update-ca-certificates
