<!-- ---
hide:
  - navigation
--- -->

# Inspec Profiles

[doc-website]: https://sommerfeld-io.github.io/inspec-profiles
[github-repo]: https://github.com/sommerfeld-io/inspec-profiles
[file-issues]: https://github.com/sommerfeld-io/inspec-profiles/issues
[project-board]: https://github.com/orgs/sommerfeld-io/projects/1/views/1

This project is a collection of Chef Inspec profiles for use in other sommerfeld-io projects.

- [Documentation Website][doc-website]
- [Github Repository][github-repo]
- [Where to file issues][file-issues]
- [Project Board for Issues and Pull Requests][project-board]

## Profile `linux-essentials`

The `linux-essentials` profile ensures all physical and virtual machines, as well as Docker images, comply with the same foundational set of rules.

Add a dependency to your `inspec.yml` file:

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

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository][file-issues].

<!-- !    File is auto-generated        -->
<!-- !    EDITS WILL BE ERASED !!!!!    -->
