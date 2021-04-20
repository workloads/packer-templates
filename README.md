# Packer Templates: HashiCorp Products

> Packer Templates for HashiCorp products for multiple (Cloud) Platforms

## Table of Contents

- [Packer Templates: HashiCorp Products](#packer-templates-hashicorp-products)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Workflow](#workflow)
    - [Supported Providers](#supported-providers)
  - [Notes](#notes)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

- Packer `1.7.2` or newer
- Terraform `0.15.0` or newer
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

The authors would like to thank [@ansible-community](https://github.com/ansible-community?q=hashicorp) and [Mark Lewis](https://github.com/ml4/base) in particular.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/packer-hashicorp/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
