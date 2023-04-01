# CTR_WORKSPACE

[![](https://img.shields.io/docker/pulls/mamoruio/workspace?style=flat-square)](https://hub.docker.com/r/mamoruio/workspace)

All-in-one image for workspace with `conda`, `vnc`, ssh-enabled ...etc

## Tags

-   `base`
-   `base-vnc`
-   `cuda11.{}`
-   `cuda11.{}-vnc`

## Quick examples

```shell
docker run -dt -e "USER=yourname" \
               -e "SHELL=zsh" \
               -e "CONDA=1" \
               --name ctr \
               --hostname "KLBS20CX" \
               mamoruio/workspace:base
```

then attach to container's shell

```shell
docker exec -it --user yourname ctr zsh
```

or connect with `ssh`

```shell
docker run -dt \
        -e "USER=yourname" \
        -e "SHELL=zsh" \
        -e "PASSWORD=passwd" \
        -p 8022:22 \
        --name ctr \
        --hostname "container_ws" \
        mamoruio/workspace:base

ssh yourname@127.0.0.1 -p 8022
```

## Environment variables

| Variable                 | Description                                                                       |
| ------------------------ | --------------------------------------------------------------------------------- |
| `-e SHELL=zsh`           | Specify your default shell (`zsh`/`bash`)<br />_default_: `bash`                  |
| `-e TZ=Asia/Tokyo`       | Specify your timezone<br />_default_: `Etc/UTC`                                   |
| `-e PASSWORD=passwd`     | Password used to authenticate the ssh login<br />_default_: `localpasswd`         |
| `-e CTR_USER=username`   | Username used for ssh login to the container<br />_default_: `ctr`                |
| `-e CTR_UID=1000`        | Specify user id for `$USER`<br />_default_: `1000`                                |
| `-e CTR_GID=5000`        | Specify group id for `$USER`<br />_default_: ` `                                  |
| `-e CTR_GROUP=groupname` | `$GROUP` will be ignored when `GID` is not given<br />_default_: ` `              |
| `-e NVIM=1`              | Specify if neovim will be installed automatically<br />_default_: ` `             |
| `-e CONDA=1`             | Specify if conda will be installed automatically<br />_default_: ` `              |
| `-e CONDA_HOME=/conda`   | Specify the path where conda will be installed <br />_default_: `$HOME/miniconda` |
| `-e START_SCRIPT=$RMT`   | Url of start script, executed after `docker run` <br />_default_: ` `             |
| `-e SCRIPT_CHANNEL=ws`   | Specify scripts' fetching channel<br />_default_: `main`                          |

## Ports

| Port      | Description                                                      |
| --------- | ---------------------------------------------------------------- |
| `-p 22`   | ssh server                                                       |
| `-p 5901` | VNC server <br /> Only available for containers with `*-vnc` tag |

## Build

Build from dockerfile

```shell
docker build --no-cache \
             -t mamoruio/workspace:local \
             -f ws.dockerfile .

docker build --no-cache \
             -t mamoruio/workspace:cuda11.3-vnc \
             -f cuda/ws.vnc.cuda11.dockerfile \
             --build-arg "CUDA_VER=11.3.0" .
```
