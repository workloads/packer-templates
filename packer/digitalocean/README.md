# Digital Ocean

## Table of Contents

- [Digital Ocean](#digital-ocean)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Overview](#overview)
  - [Authentication](#authentication)
  - [Prerequisites](#prerequisites)
  - [Images](#images)

## Requirements

- no additional requirements

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [image.pkr.hcl](image.pkr.hcl)         |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build target    | `digitalocean`                         |
| build command   | `make build target=digitalocean`       |
| lint command    | `make lint target=digitalocean`        |

> `make` commands must be run from the root directory.
## Prerequisites

|                 |                                              |
|-----------------|----------------------------------------------|
| init command    | `make terraform-init target=digitalocean`    |
| build command   | `make terraform-apply target=digitalocean`   |
| destroy command | `make terraform-destroy target=digitalocean` |

> `make` commands must be run from the root directory.
To ease in the creation of this, this repository includes a Terraform workflow (in `./terraform/digitalocean`) that can create the prerequisite resources.

For a seamless Packer experience, it is recommended to execute the Terraform workflow before the Packer workflow.

> NOTE: For an initial run, Terraform needs to be initialized using `make terraform-init target=digitalocean`

## Images

```sh
make build target=digitalocean
```

Once the build workflow completes successfully, you will be able to inspect the image in the [Digital Ocean Control Panel](https://cloud.digitalocean.com/images/custom_images).
