# Google Cloud

## Table of Contents

- [Google Cloud](#google-cloud)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Overview](#overview)
  - [Authentication](#authentication)
  - [Prerequisites](#prerequisites)
  - [Images](#images)

## Requirements

- `gcloud` (Google Cloud CLI) `321.0.0` or newer

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [image.pkr.hcl](image.pkr.hcl)         |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build target    | `google`                               |
| build command   | `make build target=google`             |
| lint command    | `make lint target=google`              |

> `make` commands must be run from the root directory.

## Authentication

Packer (and Terraform) requires authentication credentials to interact with Azure APIs.

The Azure workflow is set up to use the Google Cloud CLI `gcloud` login information to retrieve these credentials.

To log in, execute the `gcloud auth login` command and follow the instructions presented by the application.

> You will need to log in to a Google Cloud account that has permissions to create Projects, Virtual Machines, and Virtual Machine Images.

## Prerequisites

|                 |                                       |
|-----------------|---------------------------------------|
| init command    | `make terraform-init target=google`    |
| build command   | `make terraform-apply target=google`   |
| destroy command | `make terraform-destroy target=google` |

> `make` commands must be run from the root directory.

The Google Cloud workflow described in [image.pkr.hcl](image.pkr.hcl) requires an TODO to operate.

To ease in the creation of this, this repository includes a Terraform workflow (in `./terraform/google`) that can create the prerequisite resources.

For a seamless Packer experience, it is recommended to execute the Terraform workflow before the Packer workflow.

Alternatively, you can manually create an Azure Resource Group as well as the `./packer/google/generated.auto.pkrvars.hcl` file.

> NOTE: For an initial run, Terraform needs to be initialized using `make terraform-init target=google`

## Images

```sh
make build target=google
```
