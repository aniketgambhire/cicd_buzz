#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

TRAVIS_REPO_NAME=${TRAVIS_REPO_SLUG#*/}

echo $TRAVIS_REPO_NAME

docker build -f Dockerfile -t $DOCKER_USER/$TRAVIS_REPO_NAME:$TAG .
docker push $DOCKER_USER/$TRAVIS_REPO_NAME:$TAG