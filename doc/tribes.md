# n2n2-tribes

```
ssh -i ~/.ssh/n2n2 ubuntu@tribes-staging.n2n2.chat
ssh -i ~/.ssh/n2n2 ubuntu@tribes.n2n2.chat
ssh -i ~/.ssh/n2n2 ubuntu@communities.n2n2.chat
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