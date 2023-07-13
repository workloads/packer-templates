# Template: HashiCorp Vagrant

## Table of Contents

<!-- TOC -->
* [Template: HashiCorp Vagrant](#template-hashicorp-vagrant)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
    * [Build Options](#build-options)
  * [Usage](#usage)
  * [Notes](#notes)
<!-- TOC -->

## Requirements

- Packer `1.9.1` or newer
- Vagrant `2.3.7` or newer

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

|                 |                                            |
|-----------------|--------------------------------------------|
| `vagrant-cloud` | Enable output Box upload to Vagrant Cloud. |

## Usage

To build the `null` image for the `my_os` operating system, run:

```shell
make build target=null os=my_os
```

> **Note**
> `make` commands must be run from the root directory.


* Packer requires an initial Vagrant Cloud Box to be available, otherwise the upload process will fail.

* Vagrant Cloud is a subset of the Vagrant build process and cannot be executed as a stand-alone build-process.

To enable building for and deploying to [Vagrant Cloud](https://app.vagrantup.com/), pass the `vagrant-cloud` flag:

```sh
make build target=vagrant vagrant-cloud=1
```
