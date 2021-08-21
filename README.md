# Packer Templates: HashiCorp Products

> Packer Templates for HashiCorp products for multiple (Cloud) Platforms

## Table of Contents

- [Packer Templates: HashiCorp Products](#packer-templates-hashicorp-products)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Helpers](#helpers)
    - [Workflow](#workflow)
    - [Build Options](#build-options)
    - [Supported Providers](#supported-providers)
  - [Notes](#notes)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

- Packer `1.7.4` or newer
- Terraform `1.0.5` or newer
- Ansible `2.10.7` or newer

Ansible is used for system-level operations (e.g.: installing and removing packages).

Terraform is used as a helper, only. It is possible (though not advised) to manually create the resources needed.

## Usage

This repository contains Packer templates for multiple providers.

The primary way of interacting with this repository is `make` via the included [Makefile](Makefile).

This allows for a consistent execution of the underlying workflows.

The currently supported options are:

```text
PACKER TEMPLATES

help               Displays this help text
env-info           Prints Version Information
build              Builds an Image with Packer
init               Installs and upgrades Packer Plugins
lint               Formats and validates Packer Template
terraform-plan     Plans prerequisite resources with Terraform
terraform-apply    Creates prerequisite resources with Terraform
terraform-destroy  Destroys prerequisite resources with Terraform
terraform-init     Initializes Terraform
```

### Helpers

The [Makefile](Makefile) includes several unsupported helper targets that _may_ be useful when developing in this repository.

| target          | description                                        |
|-----------------|----------------------------------------------------|
| `_clean`        | (Forcefully) Removes the `generated` directory     |
| `_gen`          | Opens the `generated` directory (macOS only)       |
| `_lint_ansible` | Lints Ansible Playbooks using `ansible-lint`       |
| `_lint_yaml`    | Lints YAML files using `yamllint`                  |
| `_lint`         | Executes `_lint_yaml`, followed by `_lint_ansible` |
| `_ssh`          | Executes `vagrant ssh`                             |
| `_up`           | Executes `vagrant up`                              |
| `_vb`           | Opens "VirtualBox.app" (macOS only)                |

Unsupported targets are prefixed by an underscore (`_`).

### Workflow

The workflow for (most) targets is as follows:

- log in to provider's CLI interface
- create prerequisite resources
  - initialize Terraform (using `make terraform-init target=target`)
  - create Terraform-managed resources (using `make terraform-apply target=target`)
- create image(s)
  - initialize Packer (using `make init target=target`)
  - build Packer-managed image(s) (using `make build target=target`)
- optionally: delete prerequisite resources
  - delete Terraform-managed resources (using `make terraform-destroy target=target`)

Usage differs slightly for each provider and is therefore broken out into separate sections.

See the `packer/` (and `terraform/`) sub-directories for more information.

> All workflows _can_ be executed manually, though this is not advisable. See the [Makefile](Makefile) for more information.

### Build Options

The following generic build options are available:

#### `debug`

Disables parallelization and enables debug mode.
See [here](https://www.packer.io/docs/commands/build#debug) for more information.

#### `enable-inspec`

Enable the InSpec Provisioner and image validation against included baselines.
See [here](https://www.packer.io/docs/provisioners/inspec) for more information.

#### `except`

Run all builds, provisioners and post-processors except those with the given comma-separated names.
See [here](https://www.packer.io/docs/commands/build#except-foo-bar-baz) for more information.

#### `force`

Forces a builder to run when artifacts from a previous build prevent a build from running.
See [here](https://www.packer.io/docs/commands/build#force) for more information.

#### `machine-readable`

Enable a fully machine-readable output setting, allowing you to use Packer in automated environments.
See [here](https://www.packer.io/docs/commands#machine-readable-output) for more information.

#### `only`

Only run the builds with the given comma-separated names.
See [here](https://www.packer.io/docs/commands/build#only-foo-bar-baz) for more information.

#### `on-error`

Selects what to do when the build fails during provisioning.
See [here](https://www.packer.io/docs/commands/build#on-error-cleanup) for more information.

#### `parallel-builds`

Limit the number of builds to run in parallel.
See [here](https://www.packer.io/docs/commands/build#parallel-builds-n) for more information.

#### `timestamp-ui`

Enable prefixing of each ui output with an RFC3339 timestamp.
See [here](https://www.packer.io/docs/commands/build#timestamp-ui) for more information.

#### `var-file`

Set template variables from a file.
See [here](https://www.packer.io/docs/commands/build#var-file) for more information.

Additional Build Options may be available, depending on the target.

### Supported Providers

This repository supports the following providers:

| target    | local documentation                                  | Packer Builder  | Terraform Provider |
|-----------|------------------------------------------------------|-----------------|--------------------|
| `aws`     | [packer/aws/README.md](packer/aws/README.md)         | `amazon-ebs`    | n/a                |
| `azure`   | [packer/azure/README.md](packer/azure/README.md)     | `azure-arm`     | `azurerm`          |
| `google`  | [packer/google/README.md](packer/google/README.md)   | `googlecompute` | `google`           |
| `vagrant` | [packer/vagrant/README.md](packer/vagrant/README.md) | `vagrant`       | n/a                |

## Notes

This repository takes input and inspiration from a handful of community projects.

The authors would like to thank the following parties for their inspiration and contributions:

* [@ansible-community](https://github.com/ansible-community?q=hashicorp)
* [Mark Lewis](https://github.com/ml4/base)
* [Mike Nomitch](https://github.com/glenngillen/nomatic-stack)

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/packer-hashicorp/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
