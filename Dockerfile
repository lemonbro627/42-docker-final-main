FROM golang:1.22 as builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /my_app

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /my_app ./
COPY tracker.db ./
RUN ["/app/my_app"]