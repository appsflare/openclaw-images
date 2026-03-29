ARG ZEROCLAW_TAG=v0.6.5-debian
FROM ghcr.io/zeroclaw-labs/zeroclaw:${ZEROCLAW_TAG}

# Switch to root for all system-level installations
USER root

# Install Node.js (current LTS) via NodeSource, and sandboxing dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" \
        > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        nodejs \
        firejail \
        bubblewrap \
        liblandlock-dev && \
    rm -rf /var/lib/apt/lists/*

# Install uv (Python package and project manager) system-wide
ARG UV_VERSION=0.11.2
RUN curl -LsSf "https://astral.sh/uv/${UV_VERSION}/install.sh" | UV_INSTALL_DIR=/usr/local/bin sh

# Install claude-code and bun globally via npm
RUN npm install -g @anthropic-ai/claude-code bun

# Restore the original non-root user from the base image
USER 65534:65534
