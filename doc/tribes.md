# zion-communities

```
ssh -i ~/.ssh/zion ubuntu@communities.getzion.com
```

### Bash
```
docker kill $(docker ps -q)
eb ssh
sudo -s
docker exec -it $(docker ps --latest --quiet) sh
```

### Logs
docker ps -q | xargs -L 1 docker logs -f