# Fedora act

This image provides a convenient way to run [act](https://github.com/nektos/act) through a container. The idea is to allow
users to run Github actions locally, but without installing act.

## Runing with Podman

> [!WARNING]
> This wil run `act` as root a container. Normally, this is not an issue, but if you write files back to the repository
> in your actions, you may end up with wrong permissions.

To run this with Podman we must make sure that the `podman.sock` is running on the host, and we must mount the socket inside
the container.

To start the socket run:
```bash
systemctl --user start podman.service
```
This creates the socket at `/var/run/user/$UID/podman/podman.sock`.

Now, to run the container, run:
```bash
podman run -it --rm \
  --privileged \
  --security-opt label=disable \
  -v $(pwd):/pwd:Z \
  -v /var/run/user/$(id -u)/podman/podman.sock:/var/run/docker.sock:z \
  ghcr.io/chronoscrat/fedora-act:latest
```
All arguments for `act` can be passed after the image.

This will mount the current directory into the container and run `act`. The utility will then itself create a container and run the
actions inside of it. Because we are binding the host's `podman.sock` into the container, all images and volumes downloaded and
created by `act` will be available in the host as well.

## Running with Docker

To run this with docker, the steps are altogether similar to running with Podman.

Make sure that docker is running on the host:
```bash
systemctl start docker.service
```
Then run:
```bash
docker run -it --rm \
  --privileged \
  --security-opt label=disable \
  -v $(pwd):/pwd:Z \
  -v /var/run/docker.sock:/var/run/docker.sock:z \
  ghcr.io/chronoscrat/fedora-act:latest
```
