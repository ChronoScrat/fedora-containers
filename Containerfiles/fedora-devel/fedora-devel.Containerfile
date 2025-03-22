# Fedora Tools for Development
# This image builds upon the minimal Fedora image to include development tools such
# as RPKG, Mock, make, meson, just etc.

ARG FEDORA_REGISTRY
ARG FEDORA_IMAGE
ARG FEDORA_VERSION

FROM ${FEDORA_REGISTRY}/${FEDORA_IMAGE}:${FEDORA_VERSION}

# Add installation scripts
ADD --chmod=755 Containerfiles/fedora-devel/scripts /scripts

# Install Basic tooling
RUN scripts/tooling.sh

# Install RPM development tools
RUN scripts/devel.sh

# Install Fedora tools
RUN scripts/fedora.sh

# Install Build Tools
RUN scripts/buildtools.sh

# Clean image
RUN dnf clean all -y
RUN dnf autoremove -y
RUN rm -fr /var/cache/dnf/*
RUN rm -fr /scripts

# Configure conatiner user
# By default, we will not leave the container user as root, since
# this interferes with some build processes in Mock etc

# The user ID is hardcoded in here, but some tools (like Code's devcontainers) can change it runtime to match
# the host user's UID.
ARG USERNAME=fedora
ARG USER_UID=1000
ARG USER_GUID=${USER_UID}

# Extra groups to add the user
ARG EXTRA_GROUPS=mock

RUN groupadd --gid ${USER_GUID} ${USERNAME}
RUN useradd -m ${USERNAME} --uid ${USER_UID} --gid ${USER_GUID} -G ${EXTRA_GROUPS}
RUN echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

WORKDIR /home/${USERNAME}/
USER ${USERNAME}