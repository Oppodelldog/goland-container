#!/bin/bash

 docker run --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${SSH_AUTH_SOCK}:/run/ssh.sock -e SSH_AUTH_SOCK=/run/ssh.sock \
    -v $GOPATH:/go/ \
    -e DISPLAY=unix$DISPLAY \
    --name goland \
    goland

