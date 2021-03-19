# Packer Templates: HashiCorp Nomad

> Packer Templates for HashiCorp Nomad on AWS, Azure and Google Cloud

## Table of Contents

- [Packer Templates: HashiCorp Nomad](#packer-templates-hashicorp-nomad)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
    - [Azure images](#azure-images)
    - [Run prerequisite Terraform workflows for Azure](#run-prerequisite-terraform-workflows-for-azure)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

This repository requires Packer version `1.7.0` or newer.

## Dependencies

TODO

## Usage

This repository contains Packer templates for multiple Cloud providers. Usage differs slightly for each provider and is therefore broken out into a separate section.

All images use _Ubuntu 20.04_ as the base operating system.

### Azure

TODO

## Run prerequisite Terraform workflows for Azure

TODO

The Azure workflow described in [azure/image.pkr.hcl](azure/image.pkr.hcl) requires an Azure Resource Group to operate.

To ease in the creation of this, this repository includes a Terraform workflow (in `./terraform/azure`) that can create the prerequisite resources.

For a seamless Packer experience, it is recommended to execute the Terraform workflow before the Packer workflow.

Alternatively, you can manually create an Azure Resource Group as well as the `terraform_data.auto.pkrvars.hcl` file.

## Azure images

For Packer to be able to build images in Azure, you will need to provide authentication credentials.

The Azure workflow is set up to use the Azure CLI `az` login information to retrieve these credentials.

To log in, execute the `az login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to an Azure account that has permissions to create Virtual Machines and store Virtual Machine Images.

### Build the Azure Image

To build the Packer image, use the [build](https://www.packer.io/docs/commands/build) command:

```sh
make azure
```

This will execute the Packer build workflow for Azure images.

Once the build workflow completes successfully, you will be able to inspect the image in the [Azure Portal](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Compute%2Fimages).

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/packer-nomad/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
