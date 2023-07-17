# README for `re_load`

Github repository for the [podman](https://podman.io/) conatiner [`re_load`](https://hub.docker.com/repository/docker/khench/re_load).

## Documentation of the initial setup

Originally, the `re_load` container was build using [buildah](https://buildah.io/), from the accompanying `Containerfile`:

```sh
buildah bud -t re_load
```

To make the container publicly available, it is pushed to [dockerhub](https://hub.docker.com/r/khench/re_load) using [skopeo](https://github.com/containers/skopeo) and [podman](https://podman.io/):

```sh
skopeo login -u khench docker.io
podman push localhost/re_load docker.io/khench/re_load:v0.1
```

## Accessing the container

The bundled software can be accessed directly from [dockerhub](https://hub.docker.com/r/khench/re_load) with `apptainer` (or `docker`, or `singularity`):

```sh
apptainer run docker://khench/re_load:v0.1 rohmm --help
```