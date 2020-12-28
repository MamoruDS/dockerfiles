# CTR_WORKSPACE

> A image for workspace deployments, coming with `oh-my-zsh`, `node.js`, `conda`, ssh-enabled ...etc

## Tags

-   `latest`
-   `latest-node`

## usage

start container first

```shell
docker run -dt -e "USER=yourname" \
               -e "SHELL=zsh" \
               -e "CONDA=1" \
               --name ctr \
               --hostname "KLBS20CX" \
               mamoruio/workspace:latest
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
        mamoruio/workspace:latest

ssh yourname@127.0.0.1 -p 8022
```

## Parameters

| Parameter                        | Function                             |
| -------------------------------- | ------------------------------------ |
| `-e "SHELL=zsh"`                 | specify shell, default: `bash`       |
| `-e "TZ=Asia/Tokyo"`             | specify timezone, default: `Etc/UTC` |
| `-e "UID=1000"`                  | specify `UID`                        |
| `-e "USER=yourname"`             | default: `ctr`                       |
| `-e "PASSWORD=passwd"`           | default: `localpasswd`               |
| `-e "GIT_EMAIL=foo.bar"`         |                                      |
| `-e "GIT_NAME=foo.bar"`          |                                      |
| `-e "CONDA=1"`                   | install conda or not, default: ` `   |
| `-p 22`                          | ssh server                           |
| `--hostname "USER=container_ws"` | specify hostname                     |

## build

Pull image from docker hub

```shell
docker pull mamoruio/workspace:latest
docker pull mamoruio/workspace:latest-node
```

or build from dockerfile

```shell
docker build --no-cache \
             -t mamoruio/workspace:tag \
             -f workspace.dockerfile .
```
