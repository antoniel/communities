# n2n2-communties

This is a forked code from the Sphinx protocal. 

Decentralized message broker for public groups in N2N2. Anyone can run a N2N2-Community server, to route group messages.

N2N2-Community clients can be N2N2-relay nodes. 


[How To Deploy](ops/ansible/README.md)

## Frontend
```
cd frontend/app
npm install
npm run build
```

## Bash
```
ssh -i ~/.ssh/n2n2 ubuntu@tribes-staging.n2n2.chat
ssh -i ~/.ssh/n2n2 ubuntu@tribes.n2n2.chat
ssh -i ~/.ssh/n2n2 ubuntu@communities.n2n2.chat
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

[Tribes](doc/tribes.md)

