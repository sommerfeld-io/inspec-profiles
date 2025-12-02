# Introduction to Inspec Profiles

[file-issues]: https://github.com/sommerfeld-io/inspec-profiles/issues
[project-board]: https://github.com/orgs/sommerfeld-io/projects/1/views/1

This project is a collection of Chef Inspec profiles for use in other [sommerfeld-io](https://github.com/sommerfeld-io) projects.

- [Sonarcloud Code Quality and Security Analysis](https://sonarcloud.io/project/overview?id=sommerfeld-io_inspec-profiles)
- [Where to file issues][file-issues]
- [Project Board for Issues and Pull Requests][project-board]

## Profiles

This repository contains multiple profiles in subfolders. You cannot run them directly from the GitHub URL like single-profile repositories. So commands like `inspec exec https://github.com/dev-sec/linux-baseline` for the [Linux Baseline](https://github.com/dev-sec/linux-baseline) will not work. Instead, you need to either include the profiles as a dependency in your own profile or clone this repository and run the profiles from your local filesystem. See the individual profile README files for detailed usage instructions.

- [container-essentials](profiles/container-essentials/README.md)
- [linux-essentials](profiles/linux-essentials/README.md)

All profiles are tested with [`chef/inspec:5.22.76`](https://hub.docker.com/r/chef/inspec).

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository][file-issues].
