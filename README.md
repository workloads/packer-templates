# Packer Templates

> This directory manages Packer Images for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Packer Templates](#packer-templates)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Helpers](#helpers)
    * [Workflow](#workflow)
    * [Build Options](#build-options)
      * [`debug`](#debug)
      * [`dev`](#dev)
      * [`force`](#force)
      * [`machine-readable`](#machine-readable)
      * [`timestamp`](#timestamp)
    * [Supported Providers](#supported-providers)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.1` or [newer](https://developer.hashicorp.com/packer/downloads)
- Ansible `2.13.2` or [newer](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- a check-out of [@workloads/tooling](https://github.com/workloads/tooling)

Optional, and only needed for development and testing of Packs:

- `terraform-docs` `0.16.0` or [newer](https://terraform-docs.io/user-guide/installation/)
- `ansible-lint` `6.17.2` or [newer](https://ansible.readthedocs.io/projects/lint/installing/)

## Usage

This repository provides a workflow that is wrapped through a [Makefile](./Makefile).

Running `make` without commands will print out the following help information:

```text
🔵 PACKER TEMPLATES

Target          Description                                     Usage
init            initialize a Packer Image                       `make init target=my_target os=my_os`
lint            lint a Packer Image                             `make lint target=my_target os=my_os`
build           build a Packer Image                            `make build target=my_target os=my_os`
docs            generate documentation for all Packer Images    `make docs target=my_target os=my_os`
test            test a Packer Image                             `make test target=my_target os=my_os`
help            display a list of Make Targets                  `make help`
_listincludes   list all included Makefiles and *.mk files      `make _listincludes`
_selfcheck      lint Makefile                                   `make _selfcheck`
```


```text
clean  Remove "distributables" directory
roles  Install Ansible Collections and Roles

```

### Helpers

The [Makefile](./Makefile) includes several unsupported helper targets that _may_ be useful when developing in this repository.

| target          | description                                        |
|-----------------|----------------------------------------------------|
| `_dist`         | Opens the "distributables" directory (macOS only)  |
| `_lint_ansible` | Lints Ansible Playbooks using `ansible-lint`       |
| `_lint_yaml`    | Lints YAML files using `yamllint`                  |
| `_lint`         | Executes `_lint_yaml`, followed by `_lint_ansible` |
| `_vb`           | Opens "VirtualBox.app" (macOS only)                |

Unsupported targets are prefixed by an underscore (`_`).

### Workflow

The workflow for (most) targets is as follows:

- log in to provider's CLI interface
- create image(s)
  - initialize Packer (using `make init target=target`)
  - build Packer-managed image(s) (using `make build target=target`)

Usage differs slightly for each provider and is therefore broken out into separate sections.

See the `packer/` subdirectory for more information.

> All workflows _can_ be executed manually, though this is not advisable. See the [Makefile](./Makefile) for more information.

### Build Options

The following generic build options are available:

#### `debug`

Enables debug mode and disables parallelization.
See [here](https://developer.hashicorp.com/packer/docs/debugging) for more information.

#### `dev`

Enables _developer-mode_ and configures developer-friendly tooling.

#### `force`

Forces a builder to run when artifacts from a previous build prevent a build from running.
See [here](https://developer.hashicorp.com/packer/docs/commands/build#force) for more information.

#### `machine-readable`

Enable a fully machine-readable output setting, allowing you to use Packer in automated environments.
See [here](https://developer.hashicorp.com/packer/docs/commands#machine-readable-output) for more information.

#### `timestamp`

Prefix all build steps with an RFC3339-formatted timestamp.
See [here](https://developer.hashicorp.com/packer/docs/commands/build#timestamp-ui) for more information.

Additional Build Options may be available, depending on the target.

### Supported Providers

This repository supports the following providers:

| target         | local documentation                                    | Packer Builder                                                                         |
|----------------|--------------------------------------------------------|----------------------------------------------------------------------------------------|
| `aws`          | [packer/aws](./packer/aws/README.md)                   | [`amazon-ebs`](https://developer.hashicorp.com/packer/plugins/builders/amazon/ebs)]    |
| `azure`        | [packer/azure](./packer/azure/README.md)               | [`azure-arm`](https://developer.hashicorp.com/packer/plugins/builders/azure/arm)       |
| `digitalocean` | [packer/digitalocean](./packer/digitalocean/README.md) | [`digitalocean`](https://developer.hashicorp.com/packer/plugins/builders/digitalocean) |
| `google`       | [packer/google](./packer/google/README.md)             | [`googlecompute`](https://developer.hashicorp.com/packer/plugins/builders/azure/arm)   |
| `null`         | [packer/null](./packer/null/README.md)                 | n/a                                                                                    |
| `vagrant`      | [packer/vagrant](./packer/vagrant/README.md)           | [`vagrant`](https://developer.hashicorp.com/packer/plugins/builders/vagrant)         |

## Notes

This repository takes input and inspiration from a handful of community projects.

The authors would like to thank the following parties for their contributions:

* [@ansible-community](https://github.com/ansible-community?q=hashicorp)
* [Mark Lewis](https://github.com/ml4/base)
* [Mike Nomitch](https://github.com/mikenomitch/nomatic-stack)
* [Ryan Johnson](https://github.com/vmware-samples/packer-examples-for-vsphere)

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/packer-templates/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
