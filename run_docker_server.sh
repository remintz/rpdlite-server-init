#!/bin/bash

PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
VERBOSE=
IMAGE=hub.docker.com/remintz/rpdlite-server
MAPPED_DIR=/home/admin/node-red-user-data
MAPPED_DIR_MONGO=/home/admin/dbdata
CONTAINER_NAME=node-red-container
HOSTNAME=$(hostname -f)
MONGO_CONTAINER_NAME=mongodb-container


function usage
{
    echo "usage: run_docker.sh <options>"
    echo "options:"
    echo "     -i <image> optional - default is $IMAGE"
    echo "     -d <node red mapped dir> optional - default is $MAPPED_DIR"
    echo "     -v verbose output"
    echo "     -h prints this message"
}

while [ "$1" != "" ]; do
    case $1 in
        -i)    shift
               IMAGE=$1
               ;;

        -d)    shift
               MAPPED_DIR=$1
               ;;

        -v)    VERBOSE=-vvvvv
               ;;

        -n)    shift
               CONTAINER_NAME=$1
               ;;

        -h | --help)
               usage
               exit
               ;;

        * )    usage
               exit 1
    esac
    shift
done

if [ ! -z "$VERBOSE" ]; then
   echo $VERSION
   echo "IMAGE: $IMAGE"
   echo "CONTAINER NAME: $CONTAINER_NAME"
   echo "MAPPED DIR: $MAPPED_DIR"
   echo "VERBOSE: $VERBOSE"
fi

if [ ! "$(docker ps -a | grep $CONTAINER_NAME)" ]; then
   echo $(date -u) "Container $CONTAINER_NAME not found"
   docker run -d -p 27017:27017 -v $MAPPED_DIR_MONGO:/data/db --name $MONGO_CONTAINER_NAME mongo
   docker run -d -p 80:1880 -v $MAPPED_DIR:/data --link $MONGO_CONTAINER_NAME:mongo --hostname=$HOSTNAME --name $CONTAINER_NAME $IMAGE
else
   if [ "$(docker ps -aq -f status=running -f name=$MONGO_CONTAINER_NAME)" ]; then
      echo $(date -u) "Container $MONGO_CONTAINER_NAME already running"
   else
      echo $(date -u) "Starting container $MONGO_CONTAINER_NAME"
      docker start $MONGO_CONTAINER_NAME
   fi
   if [ "$(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]; then
      echo $(date -u) "Container $CONTAINER_NAME already running"
   else
      echo $(date -u) "Starting container $CONTAINER_NAME"
      docker start $CONTAINER_NAME
   fi
fi
