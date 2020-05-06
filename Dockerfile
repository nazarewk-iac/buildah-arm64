# based on https://github.com/containers/buildah/blob/master/contrib/buildahimage/stable/Dockerfile
ARG UPSTREAM_TAG
FROM quay.io/buildah/stable:${UPSTREAM_TAG} as upstream

FROM registry.fedoraproject.org/fedora:latest

# Don't include container-selinux and remove
# directories used by yum that are just taking
# up space.
RUN useradd build; yum -y update; yum -y reinstall shadow-utils; yum -y install buildah fuse-overlayfs --exclude container-selinux; rm -rf /var/cache /var/log/dnf* /var/log/yum.*;

COPY --from=upstream /etc/containers /etc/containers

# Adjust storage.conf to enable Fuse storage.
RUN chmod 644 /etc/containers/containers.conf; sed -i -e 's|^#mount_program|mount_program|g' -e '/additionalimage.*/a "/var/lib/shared",' -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' /etc/containers/storage.conf
RUN mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers; touch /var/lib/shared/overlay-images/images.lock; touch /var/lib/shared/overlay-layers/layers.lock

# Set an environment variable to default to chroot isolation for RUN
# instructions and "buildah run".
ENV BUILDAH_ISOLATION=chroot
