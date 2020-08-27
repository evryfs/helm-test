FROM quay.io/evryfs/base-ubuntu:focal-20200729
ENV HELM_VERSION=v3.3.0
COPY test.sh /
RUN wget -qO- https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xzv --strip-components=1 -C /usr/local/bin/ && \
	helm plugin install --version master https://github.com/sonatype-nexus-community/helm-nexus-push.git && \
COPY push_charts.sh /usr/local/bin/
CMD ["/test.sh"]
