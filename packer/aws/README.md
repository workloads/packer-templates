# Amazon Web Services

## Table of Contents

- [Amazon Web Services](#amazon-web-services)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Overview](#overview)
    - [Overrides](#overrides)
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

### Overrides

Any variables can be overridden by populating a file called `overrides.auto.pkrvars.hcl` with an identical key-value pair.

For example, to set the [AMI Name](https://www.packer.io/docs/builders/amazon/ebs#ami_name) (variable name `ami_name`) to a value of `stack`, add the following:

```ini
ami_name=stack
```

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

### Image Tagging

We have chosen to follow AWS-recommended [best-practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/adopt-a-standardized-approach-for-tag-names.html) for tagging the resulting image(s).
