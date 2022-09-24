# Template: HashiCorp Vagrant

## Table of Contents

<!-- TOC -->
* [HashiCorp Vagrant](#hashicorp-vagrant)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
    * [Build Options](#build-options)
  * [Vagrant](#vagrant)
  * [Vagrant Cloud](#vagrant-cloud)
<!-- TOC -->

## Requirements

- Vagrant `2.3.0` or newer

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [template.pkr.hcl](template.pkr.hcl)   |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build target    | `vagrant`                              |
| build command   | `make build target=vagrant os=<os>`    |
| lint command    | `make lint target=vagrant os=<os>`     |

### Build Options

The following Vagrant-specific build options are available:

|                 |                                                |
|-----------------|------------------------------------------------|
| `vagrant-cloud` | Enable output box upload[^1] to Vagrant Cloud. |

> **Note**
> `make` commands must be run from the root directory.

## Vagrant

```sh
make build target=vagrant os=ubuntu22
```

## Vagrant Cloud

Vagrant Cloud is a subset of the [Vagrant](#vagrant) build process and cannot be executed as a stand-alone build-process.

To enable building for and deploying to [Vagrant Cloud](https://app.vagrantup.com/), pass the `vagrant-cloud` flag:

```sh
make build target=vagrant vagrant-cloud=1
```

### Note

Packer requires an initial Vagrant Cloud Box to be available, otherwise the upload process will fail.
