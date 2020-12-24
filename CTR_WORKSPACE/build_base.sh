# !/bin/sh

TEMP=workspace.temp.dockerfile
BASE=$1
TAG=$2

# if [ -z $TAG ]; then
#     TAG=$BASE
# fi

cp workspace.dockerfile $TEMP
sed -i "s|^FROM[^$]*|FROM\ "$BASE"|i" $TEMP

docker build --no-cache \
             -t mamoruio/workspace:$TAG \
             -f $TEMP .
