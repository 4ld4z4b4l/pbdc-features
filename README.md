# pbdc-features

Open-source, **podman-native** Dev Container Features following the
[containers.dev](https://containers.dev) specification. Part of the **pbdc**
family (podman-based-devcontainers). The name deliberately uses the `pbdc-`
prefix and avoids the `devcontainers` tradename held by Microsoft/GitHub's
organization.

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

## Features

| `src/<feature>` | Purpose |
| --- | --- |
| `with-base` | Base-image conformance gate: rpm package manager (`dnf`/`microdnf`) required; installs nothing |
| `podman` | Installs the podman runtime |
| `podman-in-podman` | Nested rootless podman: storage volumes + UID ranges as in `quay.io/podman/stable` |
| `poop` | Podman-outside-of-podman: host socket at `/root/.poop/poop`, exposed as `CONTAINER_HOST` |
| `with-podman` | Runtime mode switch (pip/poop) via the `podman-mode` launcher; depends on pip + poop |
| `dotagents` | Installs the `@sentry/dotagents` CLI (shared coding-agent tooling; needs Node >= 20) |

Intra-collection dependencies use relative refs (`./with-base`, `./podman`, ...);
the collection is not published to any OCI registry.

## Status

Scaffolding — features are in authoring stage. Subject to change until `v1.0.0`.

## License

[BSD-3-Clause](LICENSE), Copyright (c) 2026 Aitor Aldazabal.