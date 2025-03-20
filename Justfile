
build $CONTAINERFILE:
  #!/usr/bin/bash
  set -x
  container=$(realpath ${CONTAINERFILE})
  image_file=$(basename ${container})
  image=${image_file%.*}
  tag=41

  podman build . \
    -f ${container} \
    -t ${image}:${tag}
