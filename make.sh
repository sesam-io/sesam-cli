#!/bin/bash
set -x
TAG=$TRAVIS_TAG
mkdir -p dist
for arch in amd64 386; do
  GOOS=windows GOARCH=$arch go build -ldflags "-X main.Version=$TAG" -o sesam.exe main.go
  zip dist/sesam$TAG.windows-$arch.zip sesam.exe
  rm sesam.exe
done
for os in darwin linux; do
  for arch in amd64 386; do
    GOOS=$os GOARCH=$arch go build -ldflags "-X main.Version=$TAG" -o sesam main.go
    tar -zcf dist/sesam$TAG.$os-$arch.tar.gz sesam
    rm sesam
  done
done
