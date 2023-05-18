# Build the manager binary
FROM golang:1.17 as builder

WORKDIR /devops

ENV GO111MODULE=on \
	GOPROXY=https://goproxy.cn,direct

COPY go.mod go.mod

RUN go mod download

COPY . .

RUN echo 'build finish'

# Build
RUN CGO_ENABLED=0 GOOS=linux  go build -a -o devops-demo main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM alpine:3.9
WORKDIR /devops
COPY --from=builder /devops/devops-demo .

ENTRYPOINT ["./devops-demo"]