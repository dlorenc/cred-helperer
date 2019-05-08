FROM golang:1.10
ADD https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v1.5.0/docker-credential-gcr_linux_amd64-1.5.0.tar.gz /tmp
RUN tar -C /usr/local/bin -xvzf /tmp/docker-credential-gcr_linux_amd64-1.5.0.tar.gz
RUN /usr/local/bin/docker-credential-gcr configure-docker
ADD copy-files.sh /
CMD ["/copy-files.sh"]
