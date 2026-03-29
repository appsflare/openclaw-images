ARG ZEROCLAW_TAG=v0.6.5-debian
FROM ghcr.io/zeroclaw-labs/zeroclaw:${ZEROCLAW_TAG}

# Install Node.js via NodeSource
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" \
        > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install uv (Python package and project manager) pinned to a specific version
ARG UV_VERSION=0.6.14
RUN curl -LsSf "https://astral.sh/uv/${UV_VERSION}/install.sh" | sh
ENV PATH="$HOME/.local/bin:${PATH}"

# Install claude-code and bun globally via npm
RUN npm install -g @anthropic-ai/claude-code bun

# Install sandboxing dependencies:
#   - firejail: user-space sandboxing
#   - bubblewrap: user-namespace-based sandboxing (bwrap)
#   - liblandlock-dev: Landlock LSM headers for kernel-level filesystem access control
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        firejail \
        bubblewrap \
        liblandlock-dev && \
    rm -rf /var/lib/apt/lists/*
