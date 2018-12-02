FROM ubuntu:latest
ENV HELM_VERSION=v2.11.0 UNITTEST_VERSION=v0.1.2 DEBIAN_FRONTEND=noninteractive
COPY test.sh /
RUN apt update && \
	apt install -y wget git curl ruby-dev make gcc && \
	wget -qO- https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xzv --strip-components=1 -C /usr/local/bin/ && \
	helm init --client-only && \
	helm plugin install https://github.com/lrills/helm-unittest --version ${UNITTEST_VERSION} && \
	gem install c66-copper
ENV 	https_proxy=http://proxy.evry.com:8080 \
	http_proxy=http://proxy.evry.com:8080 \
	HTTP_PROXY=http://proxy.evry.com:8080 \
	HTTPS_PROXY=http://proxy.evry.com:8080
CMD ["/test.sh"]
