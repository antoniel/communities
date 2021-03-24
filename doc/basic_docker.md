
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

### docker compose
```docker-compose
docker-compose -f docker-compose.local.yml build
docker-compose -f docker-compose.local.yml up

curl 0.0.0.0:5000
```
