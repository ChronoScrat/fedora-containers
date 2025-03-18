# Install basic tooling in the images

dnf install -y --setopt install_weak_deps=False \
    sudo \
    git \
    git-lfs