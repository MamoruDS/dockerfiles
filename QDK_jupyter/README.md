# QDK_jupyter

## usage

```shell
docker run -dt --name qdk_jupyter -p 8888:8888 mamoruio/qdk:jupyter
```

mount notebooks

```shell
docker run -dt --name qdk_jupyter -v ${NOTEBOOK}:/notebook -p 8888:8888 mamoruio/qdk:jupyter
```

## build

Pull image from docker hub

```shell
docker pull mamoruio/qdk:jupyter
```

or build from dockerfile

```shell
docker build -t mamoruio/qdk:jupyter -f QDK_jupyter/dockerfile .
```
