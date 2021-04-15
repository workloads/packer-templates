# Amazon Web Services

## Table of Contents

- [Amazon Web Services](#amazon-web-services)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Overview](#overview)
  - [Authentication](#authentication)
  - [Images](#images)
  - [Notes](#notes)

## Requirements

- `aws` (AWS CLI) `2.1.36` or newer

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [image.pkr.hcl](image.pkr.hcl)         |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build target    | `aws`                                  |
| build command   | `make build target=aws`                |
| lint command    | `make lint target=aws`                 |

> `make` commands must be run from the root directory.

## Authentication

not yet available

## Images

```sh
make build target=aws
```

️> `make` commands must be run from the root directory.

## Notes

This section contains notes that are relevant if you intend to customize the workflows of this repository.

### Operating System Choice: _Ubuntu 20.04 LTS_

We have chosen _Ubuntu 20.04 LTS_ on HVM Virtualization as the underlying OS.
This operating system is expected to be supported for a long period.

Support for additional operating systems is currently out of scope, as we want to limit complexity of this repository.

If you would like to customize this repository to fit your requirements, start by modifying the `amazon-ami` Data Source in [packer/aws/image.pkr.hcl](image.pkr.hcl).
