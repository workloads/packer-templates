# Packer Templates

> This directory manages Packer Templates for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Packer Templates](#packer-templates)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Workflow](#workflow)
  * [Notes](#notes)
    * [Ansible outside Packer](#ansible-outside-packer)
    * [Development Helpers](#development-helpers)
    * [Acknowledgements](#acknowledgements)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

- HashiCorp Packer `1.9.1` or [newer](https://developer.hashicorp.com/packer/downloads)
- Ansible `2.15.1` or [newer](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- a check-out of [@workloads/tooling](https://github.com/workloads/tooling)

Optional, and only needed for development and testing of Packs:

- `terraform-docs` `0.16.0` or [newer](https://terraform-docs.io/user-guide/installation/)
- `ansible-lint` `6.17.2` or [newer](https://ansible.readthedocs.io/projects/lint/installing/)

## Usage

This repository provides a workflow that is wrapped through a [Makefile](./Makefile).

Running `make` without commands will print out the following help information:

```text
🔵 PACKER TEMPLATES

init                initialize a Packer Image                                         `make init target=my_target os=my_os`
lint                lint a Packer Image                                               `make lint target=my_target os=my_os`
build               build a Packer Image                                              `make build target=my_target builder=my_builder os=my_os`
docs                generate documentation for all Packer Images                      `make docs target=my_target`
console             start Packer Console                                              `make console target=my_target os=my_os`
ansible_init        initialize Ansible Collections and Roles                          `make ansible_init`
ansible_inventory   construct an Ansible Inventory                                    `make ansible_inventory host=my_host user=my_user`
ansible_lint        lint Ansible Playbooks                                            `make ansible_lint`
ansible_local       run Ansible directly, outside of Packer                           `make ansible_local`
cloudinit_lint      lint cloud-init user data files using Alpine (via Docker)         `make cloudinit_lint path=./packer/templates/user-data.yml`
_clean              remove generated files                                            `make _clean`
_dist               quickly open the generated files directory (macOS only)           `make _dist`
_pd                 quickly open Parallels Desktop (macOS only)                       `make _pd`
_vb                 quickly open VirtualBox (macOS only)                              `make _vb`
_kill_vb            force-kill all VirtualBox processes (macOS only)                  `make _kill_vb`
_link_vars          create a symlink to the shared variables file for a new target    `make _link_vars target  my_target`
help                display a list of Make Targets                                    `make help`
_listincludes       list all included Makefiles and *.mk files                        `make _listincludes`
_selfcheck          lint Makefile                                                     `make _selfcheck`
```

### Workflow

The workflow for (most) targets is as follows:

- log in to provider's CLI interface
- create image(s)
  - initialize Packer (using `make init target=target`)
  - build Packer-managed image(s) (using `make build target=target`)

Usage differs slightly for each provider and is therefore broken out into separate sections.

See the `packer/` subdirectory for more information.

> All workflows _may_ be executed manually, though this is not advisable. See the [Makefile](./Makefile) for more information.

## Notes

### Ansible outside Packer

For rapid development and an improved feedback loop, Ansible may be run outside a Packer workflow. To do this, an [Ansible Inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html) may be created like so:

```shell
make ansible_inventory host=<hostname or IP address> user=vagrant
```

This will write an Ansible Inventory file to `$(ANSIBLE_INVENTORY)` (e.g.: `$(DIR_DIST)/inventory.txt`)

Once present, Ansible may be executed using `make ansible_local`


### Development Helpers

The [Makefile](./Makefile) includes several unsupported helper targets that _may_ be useful when developing additional templates and functionality.

These targets are prefixed with an underscore (`_`) and may be removed at any time.

### Acknowledgements

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
