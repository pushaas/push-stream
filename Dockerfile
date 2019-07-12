FROM ubuntu:18.04

ENV SRC_PATH /src
WORKDIR $SRC_PATH

# install dependencies
RUN apt-get update && apt-get install -y build-essential git wget libpcre3 libpcre3-dev zlib1g zlib1g-dev openssl libssl-dev

# get nginx and push-steram module, and build nginx with the module
RUN wget https://nginx.org/download/nginx-1.17.0.tar.gz \
	&& tar zxf nginx-1.17.0.tar.gz \
	&& git clone https://github.com/wandenberg/nginx-push-stream-module.git \
	&& cd nginx-1.17.0 \
	&& ./configure --add-module=../nginx-push-stream-module \
	&& make \
	&& make install \
	&& cd .. \
	&& rm nginx-1.17.0.tar.gz \
	&& rm -fr nginx-1.17.0 \
	&& rm -fr nginx-push-stream-module

EXPOSE 9080

# configure and test configuration
ADD ./nginx.conf $SRC_PATH
RUN /usr/local/nginx/sbin/nginx -c $SRC_PATH/nginx.conf -t

ENTRYPOINT /usr/local/nginx/sbin/nginx -c $SRC_PATH/nginx.conf
