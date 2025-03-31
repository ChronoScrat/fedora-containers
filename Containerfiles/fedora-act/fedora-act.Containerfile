# Fedora ACT
# This image is a wrapper around the `act` utility for running Github
# Actions locally. It is meant to be run as a privileged container.
#
# The official implementation of `act` relies on Docker, and so we provide
# it in this image. Ideally, however, the user may be able to use it with
# Podman.
#
# TODO add option to run as regular user

ARG FEDORA_REGISTRY
ARG FEDORA_IMAGE
ARG FEDORA_VERSION

FROM ${FEDORA_REGISTRY}/${FEDORA_IMAGE}:${FEDORA_VERSION}

# Install dnf plugins (required for COPR) and Podman
RUN dnf install -y --setopt install_weak_deps=False \
  dnf5-plugins \
  podman

# Install `act-cli`
RUN dnf copr enable -y chronoscrat/act-cli
RUN dnf install --refresh -y --setopt install_weak_deps=False act-cli

# Clean
RUN dnf clean all -y
RUN dnf autoremove -y
RUN rm -fr /var/cache/dnf/*

WORKDIR /pwd

ENTRYPOINT ["/usr/bin/act-cli"]
