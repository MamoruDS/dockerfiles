# CTR_WORKSPACE

This repository offers Ubuntu-based images (CUDA ready) allowing for easy deployment of a portable workspace on your host. These images come with pre-configured [dotfiles](https://github.com/MamoruDS/dotfiles), SSH accessibility, and GPU support.

Our available image can be found on the Github Package [page](https://github.com/MamoruDS/dockerfiles/pkgs/container/workspace), you can also build any of these images yourself.

> ⚠ ️Please note that all images on Docker Hub have expired, and Github Container Registry is now the only source for our images.

## Usage

Quick examples

```shell
docker run -dt --gpus all \
               -e CTR_USER=admin \
               -e SHELL=zsh \
               -e CONDA=1 \
               --name ctr_workspace \
               --hostname "ws@$HOST" \
               ghcr.io/mamoruds/workspace:cuda11.2
```

then attach to container's shell

```shell
docker exec -it --user admin ctr zsh
```

or connect with `ssh`

```shell
docker run -dt --gpus all \
               -e CTR_USER=admin \
               -e PASSWORD=passwd \
               -p 8022:22 \
               --name ctr_workspace \
               --hostname "ws@$HOST" \
               ghcr.io/mamoruds/workspace:cuda11.2

ssh admin@127.0.0.1 -p 8022
```

## Environment variables

| Variable                 | Description                                                                               |
| ------------------------ | ----------------------------------------------------------------------------------------- |
| `-e CTR_SHELL=zsh`       | Specify your default shell (`zsh`/`bash`)<br />_default_: `bash`                          |
| `-e CTR_USER=username`   | Username used for ssh login to the container<br />_default_: `ctr`                        |
| `-e CTR_UID=1000`        | Specify user id for `$USER`<br />_default_: `1000`                                        |
| `-e CTR_GID=5000`        | Specify group id for `$USER`<br />_default_: ` `                                          |
| `-e CTR_GROUP=groupname` | `$GROUP` will be ignored when `GID` is not given<br />_default_: ` `                      |
| `-e PASSWORD=passwd`     | Password used to authenticate the ssh login<br />_default_: a randomly generated password |
| `-e TZ=Asia/Tokyo`       | Specify your timezone<br />_default_: `Etc/UTC`                                           |
| `-e NVIM=1`              | Specify if neovim will be installed automatically<br />_default_: ` `                     |
| `-e CONDA=1`             | Specify if conda will be installed automatically<br />_default_: ` `                      |
| `-e CONDA_HOME=/conda`   | Specify the path where conda will be installed <br />_default_: `$HOME/miniconda`         |
| `-e START_SCRIPT=$RMT`   | Url of start script, executed after `docker run` <br />_default_: ` `                     |
| `-e SCRIPT_CHANNEL=ws`   | Specify scripts' fetching channel<br />_default_: `main`                                  |

### Dotfiles related variables

| Variable                     | Description                                                                           |
| ---------------------------- | ------------------------------------------------------------------------------------- |
| `DOTFILES_DEPLOY_SCRIPT_URL` | _default_: [dotfiles repo](https://github.com/MamoruDS/dotfiles/blob/main/install.sh) |
| `DOTFILES_PACKAGES`          |                                                                                       |
| `DOTTER_BIN_DIR`             |                                                                                       |
| `DOTFILES_ROOT`              | _default_: `$HOME/.dot.local.toml`                                                    |
| `DOTFILES_LOCAL`             |                                                                                       |


## Build

Build from Contianerfile. To find the valid corresponding CUDA and Ubuntu versions, please refer to either the available [CUDA images](https://hub.docker.com/r/nvidia/cuda/tags) or consult our [matrix](https://github.com/MamoruDS/dockerfiles/blob/main/CTR_WORKSPACE/targets_matrix.json) for Github Action.

```shell
docker build --no-cache \
             -t mamoruio/workspace:local \
             --build-arg "BASE_UBUNTU=22.04" \
             .

docker build --no-cache \
             -t mamoruio/workspace:local.cuda11.3 \
             -f Containerfile.cuda \
             --build-arg "CUDA_VER=11.3.0" \
             --build-arg "BASE_UBUNTU=20.04" \
             .
```
