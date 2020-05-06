UPSTREAM_TAG ?= v1.14.8

build:
	docker buildx build -t nazarewk/buildah-arm64:"${UPSTREAM_TAG}" --build-arg UPSTREAM_TAG="${UPSTREAM_TAG}" --platform=linux/arm64 .

push:
	docker buildx build --pull --push -t nazarewk/buildah-arm64:"${UPSTREAM_TAG}" --build-arg UPSTREAM_TAG="${UPSTREAM_TAG}" --platform=linux/arm64 .

