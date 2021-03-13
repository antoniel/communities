```
docker build -t n2n2/n2n2-tribes .
docker run n2n2/n2n2-tribes

docker run -p 5000:5000 --env-file .env n2n2/n2n2-meme

docker exec -it “container-id” bash
```

```
aws s3 sync ~/Desktop/N2N2/n2n2-tribes/ s3://n2n2-keys/n2n2-tribes --exclude "*" --include ".env"
```
