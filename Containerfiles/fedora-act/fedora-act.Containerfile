# Fedora ACT
# This image is a wrapper around the `act` utility for running Github
# Actions locally. It is meant to be run as a priviledged container.

ARG FEDORA_REGISTRY
ARG FEDORA_IMAGE
ARG FEDORA_VERSION

FROM ${FEDORA_REGISTRY}/${FEDORA_IMAGE}:${FEDORA_VERSION}

RUN dnf install -y \
    podman \
    dnf5-plugins \
    systemd

#RUN dnf copr enable chronoscrat/act-cli \
#    && dnf install --refresh -y --setopt install_weak_deps=False act

RUN dnf install -y https://download.copr.fedorainfracloud.org/results/chronoscrat/act-cli/fedora-41-x86_64/08805243-act-cli/act-v0.2.75-1.fc41.x86_64.rpm

RUN systemctl enable podman.service

#USER 1000

ENV DOCKER_HOST="unix:///var/run/podman/podman.sock"

WORKDIR /pwd

RUN /usr/bin/podman system service

ENTRYPOINT ["/usr/bin/act-cli"]