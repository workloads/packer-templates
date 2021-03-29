# Packer Templates: HashiCorp Nomad

> Packer Templates for HashiCorp Nomad (incl. Consul, and Vault) for multiple (Cloud) Platforms

## Table of Contents

- [Packer Templates: HashiCorp Nomad](#packer-templates-hashicorp-nomad)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Amazon Web Services](#amazon-web-services)
      - [Authentication](#amazon-web-services-authentication)
      - [Prerequisites](#amazon-web-services-prerequisites)
      - [Build Image](#amazon-web-services-images)
    - [Microsoft Azure](#microsoft-azure)
      - [Authentication](#microsoft-azure-authentication)
      - [Prerequisites](#microsoft-azure-prerequisites)
      - [Build Image](#microsoft-azure-images)
  - [Notes](#notes)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

- Packer `1.7.0` or newer
- Terraform `0.14.9` or newer
- Ansible `2.9.6` or newer

Ansible is used for system-level operations (e.g.: installing and removing packages).

Terraform is used as a helper, only. It is possible (though not advised) to manually create the resources needed.

## Usage

This repository contains Packer templates for multiple providers.

Usage differs slightly for each provider and is therefore broken out into separate sections.

The primary way of interacting with this repository is `make` via a [Makefile](./Makefile).

This allows for a consistent execution of the underlying workflows.

> NOTE: All workflows can be executed manually. See the [Makefile](./Makefile) for more information.

Execute `make` to get an overview of possible options:

```sh
PACKER TEMPLATES

help               Displays this help text
build              Build a Packer Image(s) for a target
init               Install and upgrade plugins for Packer Template(s) for a target
lint               Formats and validates Packer Template(s) for a target
terraform-plan     Plan prerequisite resources for a target with Terraform
terraform-apply    Create prerequisite resources for a target with Terraform
terraform-destroy  Destroy prerequisite resources for a target with Terraform
terraform-init     Initializes Terraform for a target
ansible-lint       Lints Ansible playbook(s)
```

All operations, except for `ansible-lint` and `help` require a `target`.

## Notes

This repository takes input and inspiration from a handful of community projects. The authors would like to thank: [@ansible-community](https://github.com/ansible-community) in particular.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/packer-nomad/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
