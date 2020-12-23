## 
GO111MODULE=on
## image registry host
REGISTRY?=asia.gcr.io
#
PROJECTID?=second-hand-boutique
## git commit
COMMIT?=$(shell git rev-parse HEAD)
## build date
DATE?=$(shell date "+%Y/%m/%dT%H:%M:%S")
## app name
APP_NAME?=$(shell basename ${PWD})
## image name
IMAGE_NAME?=${REGISTRY}/${PROJECTID}/${APP_NAME}:${TAG}
## server port
PORT?=58867
## server consul
CONSUL?=localhost:8500

## build: go build the application
.PHONY: build
build: clean
	go build -o api .

## run: run the application server arg: PORT , CONSUL
.PHONY: run
run:
	go run main.go server -p ${PORT} -c ${CONSUL}

## clean: golang clena
.PHONY: clean
clean:
	go clean

## docker-build: docker image build
.PHONY: docker-build
docker-build: clean check-tag
	@echo TAG ${TAG}

	@go build
	CGO_ENABLED=0 GOOS=linux go build  -a -installsuffix cgo \
    -ldflags "-X main.VERSION=${TAG} -X main.COMMIT=${COMMIT} -X main.BUILD=${DATE}" \
    -o api

	@echo "docker build image ${IMAGE_NAME}"
	docker build -t ${IMAGE_NAME} .

check-tag:
ifndef TAG
	$(error TAG not set)
endif

## help: help range
.PHONY: help
help:
	@echo "Useage:\n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

