FROM quay.io/evryfs/base-ubuntu:master
ENV HELM_VERSION=v3.2.1 UNITTEST_VERSION=v0.1.5
COPY test.sh /
RUN apt update && \
	apt install -y git ruby-dev make gcc && \
	wget -qO- https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xzv --strip-components=1 -C /usr/local/bin/ && \
	helm plugin install https://github.com/lrills/helm-unittest --version ${UNITTEST_VERSION} || true && \
	helm plugin install --version master https://github.com/sonatype-nexus-community/helm-nexus-push.git && \
	gem install c66-copper && \
	apt-get -y clean
COPY push_charts.sh /usr/local/bin/
CMD ["/test.sh"]
