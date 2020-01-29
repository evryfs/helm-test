FROM quay.io/evryfs/base-ubuntu:latest
ENV HELM_VERSION=v3.0.3 UNITTEST_VERSION=v0.1.5
COPY test.sh /
RUN apt update && \
	apt install -y git ruby-dev make gcc && \
	wget -qO- https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xzv --strip-components=1 -C /usr/local/bin/ && \
	helm plugin install https://github.com/lrills/helm-unittest --version ${UNITTEST_VERSION} && \
	helm plugin install --version master https://github.com/sonatype-nexus-community/helm-nexus-push.git && \
	gem install c66-copper && \
	apt-get -y clean
COPY push_charts.sh /usr/local/bin/
ENV 	https_proxy=http://proxy.evry.com:8080 \
	http_proxy=http://proxy.evry.com:8080 \
	HTTP_PROXY=http://proxy.evry.com:8080 \
	HTTPS_PROXY=http://proxy.evry.com:8080 \
	NO_PROXY=.evry.com,.finods.com,.cosng.net \
	no_proxy=.evry.com,.finods.com,.cosng.net
CMD ["/test.sh"]
