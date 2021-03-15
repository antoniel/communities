brew install hivemq/mqtt-cli/mqtt-cli

mqtt test -h tribes.n2n2.chat:1883
mqtt test -h 127.0.0.1:1883
mqtt test -h localhost:1883

docker run -p 5000:5000 -p 1883:1883 --env-file .env n2n2-tribes
mqtt test -h 127.0.0.1 -p 1883
