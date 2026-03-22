ARG OPENCLAW_TAG=2026.3.13-1
FROM coollabsio/openclaw:${OPENCLAW_TAG}

RUN apt-get update && \
    apt-get install -y --no-install-recommends tmux nano && \
    rm -rf /var/lib/apt/lists/*
