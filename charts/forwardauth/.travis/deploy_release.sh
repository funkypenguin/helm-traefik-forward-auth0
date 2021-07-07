#!/bin/bash
echo "Push new docker image for RELEASE $BRANCH to DockerHub."
echo "$DOCKER_PASSWD" | docker login -u "$DOCKER_USER" --password-stdin

echo "Create Tags for Image: $TRAVIS_TAG, $BRANCH and latest"
docker tag dniel/forwardauth dniel/forwardauth:$APP_VERSION-$BRANCH
docker tag dniel/forwardauth dniel/forwardauth:$BRANCH
docker tag dniel/forwardauth dniel/forwardauth:latest

echo "Push tags $TRAVIS_TAG, $BRANCH and latest to DockerHub."
docker push dniel/forwardauth:$APP_VERSION-$BRANCH
docker push dniel/forwardauth:$BRANCH
docker push dniel/forwardauth:latest

echo "Tag release on Git to know that this commit has been released."
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git tag "v$APP_VERSION"
git push https://$GH_TOKEN@github.com/dniel/traefik-forward-auth0 "v$APP_VERSION"
echo "DONE"