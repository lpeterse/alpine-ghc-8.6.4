REPO              := alpine-stackage
STACKAGE_RESOLVER := lts-13.15

.PHONY: run build

run: build
	docker run -it --rm ${REPO}

build:
	docker build -t ${REPO}:latest --build-arg STACKAGE_RESOLVER=${STACKAGE_RESOLVER} .
	docker tag ${REPO}:latest ${REPO}:${STACKAGE_RESOLVER}
