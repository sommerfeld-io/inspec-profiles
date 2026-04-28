# GitHub Copilot Instructions

## Commit Messages: Conventional Commits

Always use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) for every commit message.

**Format:** `<type>(optional scope): <description>`

| Type | Effect | When to use |
|------|--------|-------------|
| `fix` | PATCH release | Patches a bug |
| `feat` | MINOR release | Introduces a new feature |
| `BREAKING CHANGE` footer | MAJOR release | Introduces a breaking API change |
| `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test` | No release | All other changes |

**Rules:**
- A scope may be added in parentheses for extra context: `feat(parser): add ability to parse arrays`. A scope may not be with a slash (`/`).
- Breaking changes must include `BREAKING CHANGE:` in the footer: `feat: drop support for Node 6`
- Commit message titles must also match the project pattern: `^(fix|feat|build|chore|ci|docs|style|refactor|perf|test)/[a-z0-9._-]+$`

Write commit messages using the Conventional Commits format, ensuring the header (`type(scope): summary`) is clear and descriptive, as it will be displayed on GitHub release pages and used for changelogs. Focus the header on user-visible, meaningful change descriptions and avoid vague wording. Always document breaking changes explicitly in the footer using `BREAKING CHANGE:` (do not use the `!` notation).

## Project Overview

This is a **Chef InSpec compliance profiles** collection for the [sommerfeld-io](https://github.com/sommerfeld-io) organization. Profiles are reusable libraries included as dependencies in other InSpec projects — they cannot be run directly from GitHub.

| Profile | Purpose |
|---------|---------|
| `container-essentials` | Compliance checks for container images |
| `linux-essentials` | Checks for workstations and VMs (OS, packages, bash config, git, docker, ssh, etc.) |
| `ollama-essentials` | Checks for Ollama-enabled machines |

Each profile lives in `profiles/<name>/` with an `inspec.yml` (metadata + inputs) and `controls/*.rb` (control files).

## Common Commands

All commands require Docker to be running.

| Command | What it does |
|---------|-------------|
| `task lint` | Runs all linters (yaml, filenames, folders, workflows, markdown-links) via Docker Compose |
| `task check` | Validates all InSpec profiles with `chef/inspec:5.22.76` |
| `task cleanup` | Prunes Docker containers/volumes and resets filesystem permissions |

Individual linters: `docker compose up lint-<yaml|filenames|folders|workflows|markdown-links> --exit-code-from lint-<name>`
Individual profile check: `docker compose up check-profile-<container-essentials|linux-essentials|ollama-essentials> --exit-code-from check-profile-<name>`

See [.github/skills/lint-and-fix/SKILL.md](.github/skills/lint-and-fix/SKILL.md) for the full lint-and-fix workflow.

## InSpec Control Conventions

- **Control ID format**: `<topic>-<NN>` (e.g., `packages-01`, `bash-02`, `docker-01`). Each file owns its own namespace.
- **Inputs**: Declared in `inspec.yml`; referenced in controls with `input('name', value: 'fallback')`.
- **Architecture guards**: Use `if os.arch == 'x86_64'` / `if os.arch == 'aarch64'` for platform-specific controls.
- **Impact**: Use `1.0` for critical checks, lower values (e.g., `0.3`) for informational ones.
- **File checks**: Prefer `describe file(path) do ... end` over package checks when verifying binaries.
- Version numbers in `inspec.yml` must stay in sync with `package.json`.

### Control file template

```ruby
title 'Short description'

username = input('username', value: 'default_user')

control 'topic-01' do
  impact 1.0
  title 'Human-readable title'
  desc 'What is being verified and why'

  describe file('/usr/bin/example') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
end
```

## File Naming Conventions

From [`.ls-lint.yml`](.ls-lint.yml):
- `.rb`, `.yml`, `.yaml`, `.md`, `.json`, `.sh` → `kebab-case`
- `.java`, `.kt` → `PascalCase`
- `Dockerfile`, `Vagrantfile` → `PascalCase`

## Adding a New Profile

1. Create `profiles/<name>/inspec.yml` (mirror the structure of an existing profile)
2. Create `profiles/<name>/controls/<topic>.rb`
3. Add a `check-profile-<name>` service to `docker-compose.yml`
4. Add `<name>` to the `task check` loop in `taskfile.yml`
5. Link the profile README from the root `README.md`
