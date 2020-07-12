# push-stream

This is documented [here](https://github.com/pushaas/pushaas-docs#component-push-stream).

This is a simple Docker image of https://github.com/wandenberg/nginx-push-stream-module.

The image was built with a very basic Nginx configuration that **you should not use in production**. Create your own image with your configurations and use it. You should also restrict the publishing interface of the push stream module to only trusted addresses.

## running locally

```shell
make docker-build
make docker-run
```

## publishing images

```shell
make docker-push TAG=<tag>
```

---
