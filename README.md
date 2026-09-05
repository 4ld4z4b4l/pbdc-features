# podman-dc-features

Open-source, **podman-native** Dev Container Features following the
[containers.dev](https://containers.dev) specification. The name deliberately
follows the spec naming (`dc-` prefix) and avoids the `devcontainers`
tradename held by Microsoft/GitHub's organization.

Features target rootless podman end-to-end: no Docker daemon, no
`docker-outside-of-docker`, no `ghcr.io` artifacts.

## Layout

A Dev Container Features **collection**:

| Path | Purpose |
| --- | --- |
| `devcontainer-feature.json` | Collection-level manifest |
| `src/<feature>/devcontainer-feature.json` | Per-feature manifest (id, version, options) |
| `src/<feature>/install.sh` | Feature install script (run as root during image build) |
| `src/<feature>/entrypoint.sh` | Optional ENTRYPOINT replacement (runs at container start) |
| `test/<feature>/test.sh` | In-container verification for the feature |

## Status

Scaffolding — no features yet. Subject to change until `v1.0.0`.

## License

[BSD-3-Clause](LICENSE), Copyright (c) 2026 Aitor Aldazabal.