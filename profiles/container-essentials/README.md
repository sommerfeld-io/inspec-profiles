# Profile `container-essentials`

The `container-essentials` profile ensures all Docker images comply with the same foundational set of rules.

Add a dependency to the `inspec.yml` file:

```yaml
---
name: my-inspec
title: my-inspec profile
maintainer: Sebastian Sommerfeld
copyright: sommerfeld.io
copyright_email: sebastian@sommerfeld.io
license: MIT
summary: my-inspec profile to run some checks
version: 0.1.0
supports:
  platform: os
depends:
  - name: container-essentials
    git: https://github.com/sommerfeld-io/inspec-profiles.git
    branch: main
    # tag: v0.0.2
    relative_path: profiles/container-essentials
```

Call the profile from a control file (e.g., `some-control.rb`):

```rb
title "Checks for some basic stuff"

include_controls 'container-essentials' do
end
```
