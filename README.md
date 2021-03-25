# n2n2-tribes

![Tribes](doc/img/tribes.jpg)

[Tribes](doc/tribes.md)

[How To Deploy](doc/deploy.md)

```
ssh -i ~/.ssh/n2n2 ubuntu@tribes-1.n2n2.chat
sudo -s
docker exec -it $(docker ps --latest --quiet) bash
```