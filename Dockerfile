FROM golang:1.11.2-alpine3.8

WORKDIR /go/src
COPY cmd ./cmd
RUN go get -d -v ./... && go install -v ./...
CMD [ "helloworld" ]