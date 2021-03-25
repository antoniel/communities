# build stage
FROM golang:latest

ENV GO111MODULE=on

WORKDIR /app

RUN cd frontend/app && npm install && npm run build && cd /app

COPY go.mod .
COPY go.sum .
COPY config.json .
COPY plugins/auth/authhttp/http.json .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build

# final stage
FROM alpine:latest

RUN apk add --no-cache ca-certificates openssl

COPY --from=0 /app/n2n2-tribes /app/
COPY --from=0 /app/config.json /config.json
COPY --from=0 /app/plugins/auth/authhttp/http.json /plugins/auth/authhttp/http.json

EXPOSE 5000
EXPOSE 1883 
EXPOSE 5002 
ENTRYPOINT ["/app/n2n2-tribes"]