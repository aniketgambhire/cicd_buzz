#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

IFS='/' read -ra array < "$TRAVIS_REPO_SLUG"

repo_name=arrIN=(${TRAVIS_REPO_SLUG//// })

echo $DOCKER_USER/${repo_name[1]}:$TAG

docker build -f Dockerfile -t $DOCKER_USER/${repo_name[1]}:$TAG .
docker push $DOCKER_USER/${repo_name[1]}:$TAG