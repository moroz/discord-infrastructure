#!/bin/sh -e

export GOOS=${GOOS:-freebsd}
export GOARCH=${GOARCH:-amd64}
export VERSION="${VERSION:-v3.24.2}"

cd assets
rm -rf goose
git clone --depth=1 -b ${VERSION} https://github.com/pressly/goose
cd goose
go mod tidy
go build -tags='no_mysql no_ydb no_mssql no_vertica no_postgres no_clickhouse' -o goose.${GOOS} ./cmd/goose

cd ..
mv goose/goose.${GOOS} .
rm -rf goose

