# Visual Studio Code in a container
#	NOTE: Needs the redering device (yeah... idk)
#
# docker run -d \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -v ${SSH_AUTH_SOCK}:/run/ssh.sock -e SSH_AUTH_SOCK=/run/ssh.sock \
#    -v $GOPATH:/go/ \
#    -e DISPLAY=unix$DISPLAY \
#    --name goland \
#    goland
FROM debian:buster
LABEL maintainer "Nils <oppodelldog@googlemail.com>"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends \
	libxext6 \
	libxrender1 \
	libxtst6 \
	libxi6 \
	libfreetype6 \
	git \
	gcc \
	make \
	vim

#add user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
        && chown -R user:user $HOME

COPY packages/goland-2017.3.3.tar.gz /gogland-tar/goland-2017.3.3.tar.gz
RUN cd $HOME && tar -xvf /gogland-tar/goland-2017.3.3.tar.gz

ENV PATH $PATH:$HOME/GoLand-2017.3.3/bin


COPY packages/go1.10.linux-amd64.tar.gz /go-install/go1.10.linux-amd64.tar.gz

RUN tar -C /usr/local -xzf /go-install/go1.10.linux-amd64.tar.gz

ENV PATH $PATH:$HOME/GoLand-2017.3.3/bin:/usr/local/go/bin

WORKDIR $HOME

COPY start.sh /goland/start.sh

CMD [ "/goland/start.sh" ]

