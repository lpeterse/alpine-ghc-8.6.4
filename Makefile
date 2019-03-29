.PHONY:

run: build
	docker run -it --rm alpine-ghc

build:
	docker build -t alpine-ghc .
