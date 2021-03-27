# Packer Templates: HashiCorp Nomad

> Packer Templates for HashiCorp Nomad for multiple platforms

## Table of Contents

- [Packer Templates: HashiCorp Nomad](#packer-templates-hashicorp-nomad)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Amazon Web Services](#amazon-web-services)
    - [Google Cloud](#google-cloud)
      - [Authentication](#google-cloud-authentication)
      - [Prerequisite Resources](#google-cloud-prerequisite)
      - [Build Image](#google-cloud-images)
    - [Microsoft Azure](#microsoft-azure)
      - [Authentication](#microsoft-azure-authentication)
      - [Prerequisite Resources](#microsoft-azure-prerequisite)
      - [Build Image](#microsoft-azure-images)
    - [Vagrant](#vagrant)
    - [Vagrant Cloud](#vagrant-cloud)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

* Packer `1.7.0` or newer
* Terraform `0.14.9` or newer
* Ansible `2.9.6` or newer

## Usage

This repository contains Packer templates for multiple providers. Usage differs slightly for each provider and is therefore broken out into a separate section.

### Amazon Web Services

> build target `aws`

### Google Cloud

> build target `google`

#### Google Cloud Authentication

Packer (and Terraform) requires authentication credentials to interact with Google Cloud APIs.

The Google workflow is set up to use the Google Cloud CLI `gcloud` login information to retrieve these credentials.

To log in, execute the `gcloud auth login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to a Google Cloud account that has permissions to create Projects, Virtual Machines, and Virtual Machine Images.

#### Google Cloud Prerequisites

> build command: `make terraform-apply target=google`
> destroy command: `make terraform-destroy target=google`

#### Google Cloud Images

TODO

### Microsoft Azure

> build target `azure`

#### Microsoft Azure Authentication

Packer (and Terraform) requires authentication credentials to interact with Azure APIs.

The Azure workflow is set up to use the Azure CLI `az` login information to retrieve these credentials.

To log in, execute the `az login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to an Azure account that has permissions to create Resource Groups, Virtual Machines, and Virtual Machine Images.

#### Microsoft Azure Prerequisites

> build command: `make terraform-apply target=azure`
> destroy command: `make terraform-destroy target=azure`

The Azure workflow described in [azure/image.pkr.hcl](packer/azure/image.pkr.hcl) requires an Azure Resource Group to operate.

To ease in the creation of this, this repository includes a Terraform workflow (in `./terraform/azure`) that can create the prerequisite resources.

For a seamless Packer experience, it is recommended to execute the Terraform workflow before the Packer workflow.

Alternatively, you can manually create an Azure Resource Group as well as the `./packer/azure/generated.auto.pkrvars.hcl` file.

> NOTE: For an initial run, Terraform needs to be initialized using `make terraform-init target=azure`

#### Microsoft Azure Images

> build command: `make build target=azure`

Once the build workflow completes successfully, you will be able to inspect the image in the [Azure Portal](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Compute%2Fimages).

### Vagrant

> build target: `vagrant`
> build command: `make build target=vagrant`

#### Vagrant Cloud

> build target `vagrant`

Vagrant Cloud is a subset of the [Vagrant](#vagrant) build process and can not be executed as a stand-alone build-process.

To enable building for and deploying to [Vagrant Cloud](https://app.vagrantup.com/), open [packer/vagrant/image.pkr.hcl](packer/vagrant/image.pkr.hcl).

Then, uncomment the Vagrant Cloud-specific `post-processor` (near the bottom of the file) and execute a(nother) Vagrant build:

```
make build target=vagrant
```

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/packer-nomad/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
