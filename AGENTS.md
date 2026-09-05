# AGENTS.md

Agent guidance for this repository, written to the
[AGENTS.md specification](https://agents.md) and its recommended structure.
That conformance is this file's first and foremost rule.

## Project overview

`pbdc-features` is a collection of podman-native Dev Container Features
([containers.dev](https://containers.dev) spec), part of the pbdc family
(podman-based-devcontainers). Details live in README.md.

## Feature shape

Each feature lives in `src/<feature>/` with:

- `devcontainer-feature.json` — manifest (`id`, `version`, `options`, ...).
- `install.sh` — implementation, run as root during image build; options as
  env vars.
- `entrypoint.sh` — optional; replaces the container ENTRYPOINT.
- `test/<feature>/test.sh` — verification run in a throwaway container.

## Development policy

Trunk-based development:

- The default branch is `trunk`; all work lands on `trunk` in small commits.
- Short-lived branches only when a change needs review; merge back immediately.
- Releases are tags on `trunk`; no long-lived branches.