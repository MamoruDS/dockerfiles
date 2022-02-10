# CTR_WORKSPACE

[![](https://img.shields.io/docker/pulls/mamoruio/workspace?style=flat-square)](https://hub.docker.com/r/mamoruio/workspace)

All-in-one image for workspace with `conda`, `vnc`, ssh-enabled ...etc

## Tags

-   `base`
-   `base-vnc`
-   `cuda11.{}`
-   `cuda11.{}-vnc`

## Usage

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

or connect with SSH

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

## Parameters

| Parameter                | Function                                                                      |
| ------------------------ | ----------------------------------------------------------------------------- |
| `-e "START_SCRIPT=$RMT"` | start script <br />default: ` `                                               |
| `-e "SHELL=zsh"`         | specify shell<br />default: `bash`                                            |
| `-e "TZ=Asia/Tokyo"`     | specify timezone<br />default: `Etc/UTC`                                      |
| `-e "UID=1000"`          | specify `UID`                                                                 |
| `-e "USER=username"`     | default: `ctr`                                                                |
| `-e "GID=5000"`          | specify `GID` for user<br />default: ` `                                      |
| `-e "GROUP=groupname"`   | ignore when `GID` not given<br />default: ` `                                 |
| `-e "PASSWORD=passwd"`   | default: `localpasswd`                                                        |
| `-e "CONDA=1"`           | install conda or not<br />default: ` `                                        |
| `-e "CONDA_HOME=1"`      | install conda or not<br />default: `$HOME/miniconda`                          |
| `-e "CUSTOM_NVIM=1"`     | install [custom](https://github.com/MamoruDS/vimrc) neovim <br />default: ` ` |
| `-p 22`                  | ssh server                                                                    |
| `-p 5901`                | VNC server                                                                    |

## Build

build from dockerfile

```shell
docker build --no-cache \
             -t mamoruio/workspace:local \
             -f ws.dockerfile .

docker build --no-cache \
             -t mamoruio/workspace:cuda11.3-vnc \
             -f cuda/ws.vnc.cuda11.dockerfile \
             --build-arg "CUDA_VER=11.3.0" .
```
