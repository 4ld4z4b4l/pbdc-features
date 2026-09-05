# AGENTS.md

Operational guidance for AI agents working in this repository. README.md and
`docs/` are for humans; the plan/roadmap lives outside this repo.

## Conventions

- Rootless everywhere: no root daemons, no `sudo podman`, no system services.
- Do not add code comments unless asked.
- Follow the containers.dev Features spec naming (`dc-` prefix); do not use the
  `devcontainers` tradename in project naming.
- Features are container-native and podman-first: never build on Docker
  daemons, `docker-outside-of-docker`, or `ghcr.io` artifacts.
- Keep feature code boring, plain and modular: small single-purpose scripts,
  no cleverness.

## Shaping a feature

Each feature lives in `src/<feature>/` with:

- `devcontainer-feature.json` — manifest (`id`, `version`, `options`,
  `entrypoint`, `containerEnv`, `mount`, etc.).
- `install.sh` — implementation, run as root during image build; options arrive
  as env vars.
- `entrypoint.sh` — optional; replaces the container ENTRYPOINT.
- `test/<feature>/test.sh` — verification run inside a throwaway container.

Implementations use `install.sh` (or a Dockerfile when a script cannot
express the install).

## Git / identity

- The commit identity (persona) for this repo — name `Aitor Aldazabal`, email
  `aitor.aldazabal@outlook.com` — is applied externally via the
  `~/.gitconfig-github` includeif for paths under `~/code/github/`.
- **Never commit git settings.** Do not track `user.name`, `user.email`,
  `.gitconfig*`, credentials, tokens, or any identity/config file. Keep them
  strictly out of the repository.

## Workflow (trunk-based development)

- The default branch is `trunk`; all work lands on `trunk`.
- Small changes commit directly to `trunk`. Use short-lived branches only when
  a change wants review, and merge them back into `trunk` right away.
- No long-lived or release branches. Release by tagging `trunk`
  (e.g. `git tag v0.1.0 && git push origin trunk v0.1.0`).

## Build / test

```console
$ devcontainer features package --output dist    # pack features as OCI artifacts
```

Test a feature by running its `test/<feature>/test.sh` in a throwaway
container (rootless podman):

```console
$ podman run --rm -w /src -v "$PWD":/src:ro \
    registry.fedoraproject.org/fedora-minimal:latest \
    bash /src/test/<feature>/test.sh
```

## License

BSD-3-Clause, Copyright (c) 2026 Aitor Aldazabal.