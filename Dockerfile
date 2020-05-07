# based on https://github.com/containers/buildah/blob/v1.14.8/contrib/buildahimage/stable/Dockerfile
FROM registry.fedoraproject.org/fedora:latest
ARG BUILDAH_VERSION
COPY buildah-install.sh /buildah-install.sh
RUN /buildah-install.sh
ENV BUILDAH_ISOLATION=chroot
