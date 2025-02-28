# Fedora Containers

This is a collection of different Fedora Linux containers adapted for specific use-cases.
In general, the idea is that these containers should be used as [devcontainers](https://containers.dev/) or [distroboxes](https://distrobox.it/). To do this, your IDE:

1. Must provide support for devcontainers out-of-the-box (e.g.: VSCode, Proton etc); or
2. Must provide a way to perform remote connections (e.g.: Zed), and you should
    - Start the container with a container tool (e.g.: Podman or Docker)
    - Start the container with an application like Devpod

If you are using these images as distroboxes, you can also install the IDE directly inside the distrobox.

## Contributing

If you want to contribute - such as adding another image to the list - please feel free to open a PR :heart: