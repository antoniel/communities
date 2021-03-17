
# Docker Operations
### local
```
docker build -t n2n2-tribes .
docker run -p 5000:5000 --env-file .env n2n2-tribes
docker exec -it “container-id” bash
```

### remote
```
docker ps -q | xargs -L 1 docker logs -f
```

### MQTT Testing

```
docker run -p 5000:5000 -p 1883:1883 --env-file .env n2n2-tribes

curl 0.0.0.0:5000
mqtt test -h 0.0.0.0 -p 1883
```

### docker compose
```docker-compose
docker-compose -f docker-compose.local.yml build
docker-compose -f docker-compose.local.yml up

curl 0.0.0.0:5000

docker run -p 5000:5000 -p 1883:1883 --env-file .env n2n2-tribes
```
