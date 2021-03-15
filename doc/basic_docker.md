```
docker build -t n2n2-tribes .
docker run n2n2-tribes

docker run --env-file .env n2n2-tribes
docker run -p 5000:5000 --env-file .env n2n2-tribes

docker exec -it “container-id” bash

docker-compose build
```

```
aws s3 sync ~/Desktop/N2N2/n2n2-tribes/ s3://n2n2-keys/n2n2-tribes --exclude "*" --include ".env"
```
