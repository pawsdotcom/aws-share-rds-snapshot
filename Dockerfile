FROM golang:1.12.1-alpine3.9 as builder
WORKDIR /go/src/github.com/pawsdotcom/aws-share-rds-snapshot
RUN apk --no-cache add git ca-certificates
RUN go get -d -v golang.org/x/net/html github.com/aws/aws-sdk-go github.com/golang/glog
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest  
RUN apk --no-cache add git ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/pawsdotcom/aws-share-rds-snapshot/app .
CMD ["./app"] 
