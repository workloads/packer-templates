# HashiCorp Vagrant

## Table of Contents

- [HashiCorp Vagrant](#hashicorp-vagrant)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Overview](#overview)
    - [Build Options](#build-options)
    - [Overrides](#overrides)
  - [Vagrant](#vagrant)
  - [Vagrant Cloud](#vagrant-cloud)

## Requirements

- Vagrant `2.2.16` or newer

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [image.pkr.hcl](image.pkr.hcl)         |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build target    | `vagrant`                              |
| build command   | `make build target=vagrant`            |
| lint command    | `make lint target=vagrant`             |

### Build Options

The following Vagrant-specific build options are available:

|                         |                                                    |
|-------------------------|----------------------------------------------------|
| `enable-vagrant-cloud`  | set this to enable pushing to Vagrant Cloud        |

> `make` commands must be run from the root directory.

### Overrides

Any variables can be overridden by populating a file called `overrides.auto.pkrvars.hcl` with an identical key-value pair.

For example, to set the [Box Name](https://www.packer.io/docs/builders/vagrant#box_name) (variable name `box_name`) to a value of `stack`, add the following:

```ini
box_name=stack
```

## Vagrant

```sh
make build target=vagrant
```

## Vagrant Cloud

Vagrant Cloud is a subset of the [Vagrant](#vagrant) build process and cannot be executed as a stand-alone build-process.

To enable building for and deploying to [Vagrant Cloud](https://app.vagrantup.com/), pass the `enable-vagrant-cloud` flag:

```sh
make build target=vagrant enable-vagrant-cloud=1
```

> `make` commands must be run from the root directory.
