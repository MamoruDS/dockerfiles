# Examples

## Basic usages

### ssh access

```
docker run -dt \
        -e "USER=yourname" \
        -e "PASSWORD=passwd" \
        -p 8022:22 \
        --name ctr_ssh_demo \
        mamoruio/workspace:base

ssh yourname@127.0.0.1 -p 8022
```

### gpu support

Create a container to work with nvidia GPUs and `CUDA`

```shell
# gpu support testing
docker run --rm \
    --gpus all \
    mamoruio/workspace:cuda11.3 nvidia-smi
```
