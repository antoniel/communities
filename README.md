# n2n2-tribes

![Tribes](doc/img/tribes.jpg)

[How To Deploy](ops/ansible/README.md)

## Frontend
```
cd frontend/app
npm install
npm run build
```

## Bash
```
ssh -i ~/.ssh/n2n2 ubuntu@tribes-1.n2n2.chat
sudo -s
docker exec -it $(docker ps --latest --quiet) bash
```


## Database
```
truncate table tribes;
```

## Logs

```
docker ps -q | xargs -L 1 docker logs -f
```

[Tribes](doc/tribes.md)

