ARG ZEROCLAW_TAG=v0.6.5-debian
FROM ghcr.io/zeroclaw-labs/zeroclaw:${ZEROCLAW_TAG}

# Switch to root for all system-level installations
USER root

# Install sandboxing dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        firejail \
        bubblewrap && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS) directly from nodejs.org (includes npm)
ARG NODE_VERSION=24.14.1
RUN curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" \
        -o /tmp/node.tar.gz && \
    echo "ace9fa104992ed0829642629c46ca7bd7fd6e76278cb96c958c4b387d29658ea  /tmp/node.tar.gz" | sha256sum -c - && \
    tar -xz --strip-components=1 -C /usr/local -f /tmp/node.tar.gz && \
    rm /tmp/node.tar.gz

# Install uv (Python package and project manager) from GitHub releases
ARG UV_VERSION=0.11.2
RUN curl -fsSL "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz" \
        -o /tmp/uv.tar.gz && \
    echo "7ac2ca0449c8d68dae9b99e635cd3bc9b22a4cb1de64b7c43716398447d42981  /tmp/uv.tar.gz" | sha256sum -c - && \
    tar -xz --strip-components=1 -C /usr/local/bin -f /tmp/uv.tar.gz && \
    rm /tmp/uv.tar.gz

# Install Claude Code using the native installer layout
# Replicates what `curl -fsSL https://claude.ai/install.sh | sh` does:
# a local npm installation (not npm install -g) with a binary on PATH.
# Using /opt/claude-code as the install root so the non-root runtime user
# can execute the binary without needing access to /root/.
# See: https://github.com/anthropics/claude-code#get-started
ARG CLAUDE_CODE_VERSION=latest
RUN mkdir -p /opt/claude-code && \
    cd /opt/claude-code && \
    npm install @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} && \
    ln -sf /opt/claude-code/node_modules/.bin/claude /usr/local/bin/claude

# Install bun globally via npm
RUN npm install -g bun

# Restore the original non-root user from the base image
USER 65534:65534
