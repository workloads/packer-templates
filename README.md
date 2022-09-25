# Packer Templates

> Packer Templates for HashiCorp products for multiple (Cloud) Platforms

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
      * [`force`](#force)
      * [`machine-readable`](#machine-readable)
    * [Supported Providers](#supported-providers)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- Packer `1.8.3` or newer
- Ansible `2.13.1` or newer

Ansible is used for system-level operations (e.g.: installing and removing packages).

## Usage

This repository contains Packer templates for multiple providers.

The primary way of interacting with this repository is `make` via the included [Makefile](./Makefile).

This allows for a consistent execution of the underlying workflows.

The currently supported options are:

```text
PACKER TEMPLATES

help   Displays this help text
init   Installs and upgrades Packer Plugins      Usage: `make init target=<target> os=<os> os=<os>`
build  Builds an Image with Packer               Usage: `make build target=<target> os=<os>`
lint   Formats and validates Packer Template     Usage: `make lint target=<target> os=<os>`
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

| target    | local documentation                                    | Packer Builder  |
|-----------|--------------------------------------------------------|-----------------|
| `aws`     | [packer/aws/README.md](./packer/aws/README.md)         | `amazon-ebs`    |
| `azure`   | [packer/azure/README.md](./packer/azure/README.md)     | `azure-arm`     |
| `google`  | [packer/google/README.md](./packer/google/README.md)   | `googlecompute` |
| `null`    | [packer/null/README.md](./packer/null/README.md)       | n/a             |
| `vagrant` | [packer/vagrant/README.md](./packer/vagrant/README.md) | `vagrant`       |

## Notes

This repository takes input and inspiration from a handful of community projects.

The authors would like to thank the following parties for their inspiration and contributions:

* [@ansible-community](https://github.com/ansible-community?q=hashicorp)
* [Mark Lewis](https://github.com/ml4/base)
* [Mike Nomitch](https://github.com/glenngillen/nomatic-stack)
* [Ryan Johnson](https://github.com/vmware-samples/packer-examples-for-vsphere)

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/packer-templates/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
