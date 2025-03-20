# Fedora R Image
# This image includes a minimal installation of the R language,
# a few required fedora packages and the `renv` R library. It is
# best used as the base for devcontainers (in Zed, Code, Proton etc)
# or as a clean environent for headless code execution.
#
# NOTE: this image includes RSPM as the default CRAN source for R

ARG FEDORA_REGISTRY=registry.fedoraproject.org
ARG FEDORA_IMAGE=fedora-minimal
ARG FEDORA_VERSION=41

FROM ${FEDORA_REGISTRY}/${FEDORA_IMAGE}:${FEDORA_VERSION}

# Latest RHEL version - This *should* work on the current fedora version
ENV RHEL_LIKE="rhel9"

# Install basic tooling
RUN dnf install -y --setopt install_weak_deps=False \
  git \
  git-lfs \
  sudo \
  curl \
  curl-devel

# Install R
RUN dnf install -y --setopt install_weak_deps=False \
  R

# Add RSPM as the default CRAN source for R
ENV R_HOME=/usr/lib64/R
ENV CRAN="https://p3m.dev/cran/__linux__/${RHEL_LIKE}/latest"

RUN echo "options(repos = c(CRAN = '${CRAN}'), download.file.method = 'libcurl')" >> "${R_HOME}/etc/Rprofile.site"

# Set the User-Agent for R
RUN cat <<EOF >>"${R_HOME}/etc/Rprofile.site"
# https://docs.rstudio.com/rspm/admin/serving-binaries/#binaries-r-configuration-linux
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))
EOF

# Add site library
RUN echo "R_LIBS=\${R_LIBS-'${R_HOME}/library'}" >> "${R_HOME}/etc/Renviron.site"

# Install renv
RUN Rscript -e "install.packages('renv')"
