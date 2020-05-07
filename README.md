# buildah-arm64
arm64 compatible build of https://github.com/containers/buildah/blob/master/contrib/buildahimage/stable

notes:
- image is self-built on the Kubernetes cluster (`k3os` to be exact) running on rpi4, 
    because i failed to set up DNS when using `docker buildx build` for cross-platform build,
- `fuse` module needs to be available on the build nodes (`modprobe fuse`)
- current bake job is quickly put together without much consideration for the security of build process,
