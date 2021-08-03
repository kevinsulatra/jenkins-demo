FROM alpine/helm:3.6.2

RUN apk --no-cache add git
RUN helm plugin install https://github.com/chartmuseum/helm-push
