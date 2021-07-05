FROM alpine/helm:latest

RUN apk --no-cache add git
RUN helm plugin install https://github.com/chartmuseum/helm-push
