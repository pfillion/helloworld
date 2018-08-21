FROM golang:alpine

ENV YOUR_NAME "World"

WORKDIR /go/src/app
COPY helloworld.go .
RUN go get -d -v ./...
RUN go install -v ./...
CMD [ "app" ]

# Sample with shell script
# COPY docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]