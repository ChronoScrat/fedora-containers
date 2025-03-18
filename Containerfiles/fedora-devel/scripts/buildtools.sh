# Install buildtools inside the image

dnf install -y --setopt install_weak_deps=False \
    make \
    mason \
    just