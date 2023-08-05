#!/usr/bin/env bash
set -eu

GIT_USER_EMAIL=$(git config --get --default "<not set>" user.email)

if [[ "$GIT_USER_EMAIL" != "<not set>" ]]; then
  echo "[git] user.email is set - $GIT_USER_EMAIL"
else
  echo '[git] setting user.email to "jaejae1112@gmail.com"'
  git config --global user.email "jaejae1112@gmail.com"
fi

GIT_USER_NAME=$(git config --get --default "<not set>" user.name)

if [[ "$GIT_USER_NAME" != "<not set>" ]]; then
  echo "[git] user.name is set - $GIT_USER_NAME"
else
  echo '[git] setting user.name to "Jaewan Park"'
  git config --global user.name "Jaewan Park"
fi
