.PHONY: \
	docker-build \
	docker-run \
	docker-build-and-run \
	docker-push

CONTAINER := push-stream
IMAGE := rafaeleyng/push-stream
IMAGE_TAGGED := $(IMAGE):latest
NETWORK := push-service-network
PORT_CONTAINER := 9080
PORT_HOST := 9080

docker-build:
	@docker build \
		-t $(IMAGE) \
		.

docker-clean:
	@-docker rm -f $(CONTAINER)

docker-run: docker-clean
	@docker run \
		-d \
		--name $(CONTAINER) \
		--network $(NETWORK) \
		-p $(PORT_HOST):$(PORT_CONTAINER) \
		$(IMAGE_TAGGED)

docker-build-and-run: docker-build docker-run

docker-push: docker-build
	@docker push \
		$(IMAGE)
