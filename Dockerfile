FROM ubuntu:18.04

ENV SRC_PATH /src
WORKDIR $SRC_PATH

# install dependencies
RUN apt-get update
RUN apt-get install -y build-essential git wget libpcre3 libpcre3-dev zlib1g zlib1g-dev openssl libssl-dev

# get nginx and push-steram module
RUN wget https://nginx.org/download/nginx-1.17.0.tar.gz && tar zxf nginx-1.17.0.tar.gz
RUN git clone https://github.com/wandenberg/nginx-push-stream-module.git

# build nginx
WORKDIR $SRC_PATH/nginx-1.17.0
RUN ./configure --add-module=../nginx-push-stream-module
RUN make
RUN make install

EXPOSE 9080

# configure and test configuration
ADD ./nginx.conf $SRC_PATH
RUN /usr/local/nginx/sbin/nginx -c $SRC_PATH/nginx.conf -t

ENTRYPOINT /usr/local/nginx/sbin/nginx -c $SRC_PATH/nginx.conf
