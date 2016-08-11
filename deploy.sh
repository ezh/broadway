#!/bin/sh
COMMIT=$(git rev-parse HEAD | cut -c1-8)
docker login -e=$DOCKER_EMAIL -u=$DOCKER_USER -p=$DOCKER_PASSWORD
docker-compose run -e CGO_ENABLED=0 test go build -a -installsuffix cgo -ldflags "-s" github.com/namely/broadway/cmd/broadway
docker build -t namely/broadway:$COMMIT -f Dockerfile-build .
docker push namely/broadway:$COMMIT
