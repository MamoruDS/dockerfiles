# CTR_WORKSPACE

| A image for workspace deployments, coming with `oh-my-zsh`, `node.js`, `conda`, ssh-enabled ...etc

## build

Pull image from docker hub

```shell
docker pull mamoruio/workspace:latest
```

or build from dockerfile

arguments:

-   USERNAME: your username, default `ctr`
-   PASSWORD: password for `$USERNAME`, default `localpasswd`
-   TZ: your timezone

```shell
docker build --build-arg USERNAME=username \
             --build-arg PASSWORD=password \
             --build-arg TZ=Asia/Shanghai \
             -t mamoruio/workspace:tag \
             -f workspace.dockerfile .
```

## usage

Start container first

```shell
docker run -dt --name ctr_ws -h CTRWS mamoruio/workspace:latest
```

then attach to container's shell

```shell
docker exec -it ctr_ws zsh
```

or connect with SSH

-   mount your workspace

    ```shell
    docker run -dt --name ctr_ws -v ${WORKSPACE}:/WORKSPACE mamoruio/workspace:latest
    ```

-   connect with SSH

    ```shell
    docker run -dt --name ctr_ws -p 8022:22 mamoruio/workspace:latest
    ```

    You can use SSH key to access your container, mount `authorized_keys` to container or put it in `keys/` before build

    update your ssh config file with ⬇️

    ```
    Host CTR
        HostName 127.0.0.1
        User ctr
        Port 8022
        StrictHostKeyChecking no
        IdentityFile ~/.ssh/key_for_container
    ```
