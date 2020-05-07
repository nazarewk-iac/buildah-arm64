#!/usr/bin/env bash
# based on https://github.com/containers/buildah/blob/v1.14.8/contrib/buildahimage/stable/Dockerfile
# to be run in fedora image
set -xeEuo pipefail

# Don't include container-selinux and remove
# directories used by yum that are just taking
# up space.
useradd build; yum -y update; yum -y reinstall shadow-utils; yum -y install "buildah-${BUILDAH_VERSION}" fuse-overlayfs --exclude container-selinux; rm -rf /var/cache /var/log/dnf* /var/log/yum.*;

curl https://raw.githubusercontent.com/containers/buildah/d4103b788d81fcb7a43baa58f756309c6df3f783/contrib/buildahimage/stable/containers.conf > /etc/containers/containers.conf

# Adjust storage.conf to enable Fuse storage.
chmod 644 /etc/containers/containers.conf; sed -i -e 's|^#mount_program|mount_program|g' -e '/additionalimage.*/a "/var/lib/shared",' -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' /etc/containers/storage.conf

# Set an environment variable to default to chroot isolation for RUN
# instructions and "buildah run".
mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers; touch /var/lib/shared/overlay-images/images.lock; touch /var/lib/shared/overlay-layers/layers.lock
