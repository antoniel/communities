```
docker build -t n2n2-tribes .
docker run -p 5000:5000 --env-file .env n2n2-tribes
docker ps -q | xargs -L 1 docker logs -f

docker exec -it “container-id” bash


docker-compose build
```

```
aws s3 sync ~/Desktop/N2N2/n2n2-tribes/ s3://n2n2-keys/n2n2-tribes --exclude "*" --include ".env"
```

## MQTT

```
docker run -p 5000:5000 -p 1883:1883 --env-file .env n2n2-tribes

curl 0.0.0.0:5000
mqtt test -h 0.0.0.0 -p 1883
```

```docker-compose
docker-compose -f docker-compose.local.yml build
docker-compose -f docker-compose.local.yml up

curl 0.0.0.0:5000

docker run -p 5000:5000 -p 1883:1883 --env-file .env n2n2-tribes
```
