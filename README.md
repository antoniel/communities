# zion-communties

This is a forked code from the Sphinx protocal. 

Decentralized message broker for public groups in ZION. Anyone can run a ZION-Community server, to route group messages.

ZION-Community clients can be ZION-relay nodes. 


[How To Deploy](ops/ansible/README.md)

## Frontend
```
cd frontend/app
npm install
npm run build
```

## Bash
```
ssh -i ~/.ssh/zion ubuntu@communities.getzion.com
ssh -i ~/.ssh/zion ubuntu@communities.getzion.com
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

## Private Key (PRIV_KEY)

```
base64 n2n2-0
base64 -d n2n2-0.encoded 
```

[Communities](doc/tribes.md)

