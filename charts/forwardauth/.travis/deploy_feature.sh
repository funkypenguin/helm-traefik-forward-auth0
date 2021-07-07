#!/bin/bash
echo "Push new docker image for FEATURE $BRANCH to DockerHub."
echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_USER" --password-stdin

echo "Create Tags for Image: $TRAVIS_TAG and $BRANCH"
docker tag dniel/forwardauth dniel/forwardauth:$APP_VERSION-$BRANCH
docker tag dniel/forwardauth dniel/forwardauth:$BRANCH

echo "Push tags $TRAVIS_TAG and $BRANCH to DockerHub."
docker push dniel/forwardauth:$APP_VERSION-$BRANCH
docker push dniel/forwardauth:$BRANCH
echo "DONE"