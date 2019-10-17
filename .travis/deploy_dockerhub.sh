#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

IFS='/' read -ra array < "$TRAVIS_REPO_SLUG"

repo_name=${array[${#arr[@]}-1]}

docker build -f Dockerfile -t $DOCKER_USER/$repo_name:$TAG .
docker push $DOCKER_USER/$repo_name:$TAG

echo $DOCKER_USER/$repo_name:$TAG