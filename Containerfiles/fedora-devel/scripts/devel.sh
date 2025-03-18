# Install basic RPM development packages

dnf install -y --setopt install_weak_deps=False \
    rpm-build \
    rpm-devel \
    rpmlint \
    rpmdevtools \
    diffutils \
    patch \
    rpkg \
    mock