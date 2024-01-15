FROM python:3.11-slim
ENV PYTHONUNBUFFERED 1

# Add Tini (init system) to handle signals correctly.
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Install dependencies.
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    git

# Copy in the init script.
COPY ./init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 8188
CMD ["/init.sh"]