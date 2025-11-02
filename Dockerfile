FROM golang:1.25-alpine AS development

WORKDIR /app

RUN go install github.com/air-verse/air@latest

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main .

CMD ["air", "-c", ".air.toml"]

FROM alpine:3.22

WORKDIR /app

COPY --from=development /app/main .

CMD ["./main"]
