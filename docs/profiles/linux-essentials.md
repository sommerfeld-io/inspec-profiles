# Profile `linux-essentials`

The `linux-essentials` profile ensures all physical and virtual machines, as well as Docker images, comply with the same foundational set of rules.

> :zap: **Note**: This profile is intended to run against our infrastructure and is not designed for public use. It may contain checks that are specific to our environment and may not be applicable to other systems.

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
  - name: linux-essentials
    git: https://github.com/sommerfeld-io/inspec-profiles.git
    branch: main
    # tag: v0.0.2
    relative_path: profiles/linux-essentials
```

Call the profile from a control file (e.g., `some-control.rb`):

```rb
title "Checks for some basic stuff"

include_controls 'linux-essentials' do
end
```
