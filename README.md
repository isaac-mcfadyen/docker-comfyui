# comfyui-docker

The ComfyUI Stable Diffusion client packaged in a Docker container for easy redistribution.

- Only NVIDIA GPUs supported for now.
- Make sure to install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) and **restart your Docker daemon** before first use.
- View the example `compose.yaml` for instructions on how to persist things across reboot. **WARNING**: not persisting the `/comfyui` folder will cause every dependency to be redownloaded when the container is destroyed and recreated.

### Configuration

- `xformers` can be faster on some older GPUs than PyTorch 2's Cross Attention. If you have an older GPU (RTX 2xxx, maybe some RTX 3xxx GPUs), make sure to set `USE_XFORMERS` to `true` when running the container. Newer NVIDIA GPUs should keep it set to false (the default) for greater speedups.
- Set `COMFYUI_COMMIT` to a git commit hash to pull a specific commit of ComfyUI, or to `master` (the default) to pull the latest version of ComfyUI.

> **Why can't we embed ComfyUI in the image directly? Why is it installed at build-time?**
> Some ComfyUI custom nodes require other dependencies. We could simply embed ComfyUI in the Docker image directly, but even if we bind-mounted the `custom_nodes` folder into the container the custom nodes would still need to reinstall their dependencies every run, which makes for quite a slow startup.
