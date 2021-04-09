# Microsoft Azure

## Table of Contents

- [Microsoft Azure](#microsoft-azure)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Authentication](#authentication)
  - [Prerequisites](#prerequisites)
  - [Images](#images)

## Overview

|                 |                                        |
|-----------------|----------------------------------------|
| image template  | [image.pkr.hcl](image.pkr.hcl)         |
| image variables | [variables.pkr.hcl](variables.pkr.hcl) |
| build target    | `azure`                                |
| build command   | `make build target=azure`              |
| lint command    | `make lint target=azure`               |

> `make` commands must be run from the root directory.

## Authentication

Packer (and Terraform) requires authentication credentials to interact with Azure APIs.

The Azure workflow is set up to use the Azure CLI `az` login information to retrieve these credentials.

To log in, execute the `az login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to an Azure account that has permissions to create Resource Groups, Virtual Machines, and Virtual Machine Images.

## Prerequisites

|                 |                                       |
|-----------------|---------------------------------------|
| init command    | `make terraform-init target=azure`    |
| build command   | `make terraform-apply target=azure`   |
| destroy command | `make terraform-destroy target=azure` |

> `make` commands must be run from the root directory.

The Azure workflow described in [image.pkr.hcl](image.pkr.hcl) requires an Azure Resource Group to operate.

To ease in the creation of this, this repository includes a Terraform workflow (in `./terraform/azure`) that can create the prerequisite resources.

For a seamless Packer experience, it is recommended to execute the Terraform workflow before the Packer workflow.

Alternatively, you can manually create an Azure Resource Group as well as the `./packer/azure/generated.auto.pkrvars.hcl` file.

> NOTE: For an initial run, Terraform needs to be initialized using `make terraform-init target=azure`

## Images

```sh
make build target=azure
```

Once the build workflow completes successfully, you will be able to inspect the image in the [Azure Portal](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Compute%2Fimages).
