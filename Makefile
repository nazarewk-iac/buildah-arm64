BUILDAH_VERSION ?= 1.14.8
REPOSITORY ?= nazarewk/buildah-arm64
IMAGE ?= ${REPOSITORY}:v${BUILDAH_VERSION}

.ONESHELL:

apply:
	kubectl apply -k .

reapply:
	kubectl -n buildah-arm64-bake delete job buildah || true
	$(MAKE) apply

delete:
	kubectl delete -k .
