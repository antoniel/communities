# n2n2-tribes

### Bash
```
eb ssh
sudo -s
docker exec -it $(docker ps --latest --quiet) sh
```

### Logs
docker ps -q | xargs -L 1 docker logs -f