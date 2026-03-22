# openclaw-images

Docker images extending [coollabsio/openclaw](https://hub.docker.com/r/coollabsio/openclaw) with additional tools.

## Images

### `openclaw` (base)

Extends `coollabsio/openclaw` with:
- [`tmux`](https://github.com/tmux/tmux) — terminal multiplexer
- [`nano`](https://www.nano-editor.org/) — terminal text editor

## Building locally

```bash
# Build with the default base image tag (2026.3.13-1)
docker build -t openclaw-extended .

# Override the base image tag
docker build --build-arg OPENCLAW_TAG=2026.3.13-2 -t openclaw-extended .
```

## CI/CD — GitHub Actions

The repository includes a workflow at `.github/workflows/docker-build-publish.yml` that automatically builds and publishes images to the **GitHub Container Registry (GHCR)** at `ghcr.io/<owner>/openclaw`.

### How it works

| Event | Build | Publish |
|---|---|---|
| Push to `main` | ✅ | ✅ Tagged `latest` |
| Push a `v*` tag | ✅ | ✅ Tagged with semver (e.g. `v1.0.0`, `1.0`) |
| Pull request to `main` | ✅ | ❌ (build-only validation) |
| Manual dispatch | ✅ | ✅ |

### Required configuration

**No extra secrets are needed.** The workflow uses the built-in `GITHUB_TOKEN` with `packages: write` permission, which is automatically granted by GitHub Actions.

The only repository-level setting to confirm:

1. **Package visibility** — when a package is first created in GHCR it inherits the repository's visibility (public/private). You can change this later under **Settings → Packages** on GitHub.
2. **For organisation repositories** — ensure *"Improved container support"* is enabled in the organisation settings (this is on by default for all GitHub.com organisations).

### Manual dispatch

You can trigger a build manually from the **Actions** tab and optionally override the base image tag:

```
OPENCLAW_TAG: 2026.3.13-2   # defaults to 2026.3.13-1
```

### Pulling the published image

```bash
docker pull ghcr.io/<owner>/openclaw:latest
```