# Packer Templates: HashiCorp Nomad

> Packer Templates for HashiCorp Nomad (incl. Consul, and Vault) for multiple (Cloud) Platforms

## Table of Contents

- [Packer Templates: HashiCorp Nomad](#packer-templates-hashicorp-nomad)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Amazon Web Services](#amazon-web-services)
      - [Authentication](#amazon-web-services-authentication)
      - [Prerequisites](#amazon-web-services-prerequisites)
      - [Build Image](#amazon-web-services-images)
    - [Google Cloud](#google-cloud)
      - [Authentication](#google-cloud-authentication)
      - [Prerequisites](#google-cloud-prerequisites)
      - [Build Image](#google-cloud-images)
    - [Microsoft Azure](#microsoft-azure)
      - [Authentication](#microsoft-azure-authentication)
      - [Prerequisites](#microsoft-azure-prerequisites)
      - [Build Image](#microsoft-azure-images)
    - [Vagrant](#vagrant)
    - [Vagrant Cloud](#vagrant-cloud)
      - [Build Image](#vagrant-cloud-images)
  - [Notes](#notes)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

- Packer `1.7.0` or newer
- Terraform `0.14.9` or newer
- Ansible `2.9.6` or newer

## Usage

This repository contains Packer templates for multiple providers.

Usage differs slightly for each provider and is therefore broken out into separate sections.

### Amazon Web Services

> image template: [./packer/aws/image.pkr.hcl](./packer/aws/image.pkr.hcl)
> image variables: [./packer/aws/variables.pkr.hcl](./packer/aws/variables.pkr.hcl)
> build target: `aws`
> build command: `make build target=aws`

#### Amazon Web Services Authentication

not yet available

#### Amazon Web Services Prerequisites

not yet available

#### Amazon Web Services Images

not yet available

### Google Cloud

> image template: [./packer/google/image.pkr.hcl](./packer/google/image.pkr.hcl)
> image variables: [./packer/google/variables.pkr.hcl](./packer/google/variables.pkr.hcl)
> build target: `google`
> build command: `make build target=google`

#### Google Cloud Authentication

Packer (and Terraform) requires authentication credentials to interact with Google Cloud APIs.

The Google workflow is set up to use the Google Cloud CLI `gcloud` login information to retrieve these credentials.

To log in, execute the `gcloud auth login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to a Google Cloud account that has permissions to create Projects, Virtual Machines, and Virtual Machine Images.

#### Google Cloud Prerequisites

> init command `make terraform-init target=google`
> build command: `make terraform-apply target=google`
> destroy command: `make terraform-destroy target=google`

#### Google Cloud Images

not yet available

### Microsoft Azure

> image template: [./packer/azure/image.pkr.hcl](./packer/azure/image.pkr.hcl)
> image variables: [./packer/azure/variables.pkr.hcl](./packer/azure/variables.pkr.hcl)
> build target: `azure`
> build command: `make build target=azure`

#### Microsoft Azure Authentication

Packer (and Terraform) requires authentication credentials to interact with Azure APIs.

The Azure workflow is set up to use the Azure CLI `az` login information to retrieve these credentials.

To log in, execute the `az login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to an Azure account that has permissions to create Resource Groups, Virtual Machines, and Virtual Machine Images.

#### Microsoft Azure Prerequisites

> init command `make terraform-init target=azure`
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

> image template: [./packer/vagrant/image.pkr.hcl](./packer/vagrant/image.pkr.hcl)
> image variables: [./packer/vagrant/variables.pkr.hcl](./packer/vagrant/variables.pkr.hcl)
> build target: `vagrant`
> build command: `make build target=vagrant`

#### Vagrant Cloud

> build target `vagrant`

Vagrant Cloud is a subset of the [Vagrant](#vagrant) build process and cannot be executed as a stand-alone build-process.

#### Vagrant Cloud Images

To enable building for and deploying to [Vagrant Cloud](https://app.vagrantup.com/), open [packer/vagrant/image.pkr.hcl](packer/vagrant/image.pkr.hcl).

Then, uncomment the Vagrant Cloud-specific `post-processor` (near the bottom of the file) and execute a build targetted at `vagrant`:

```sh
make build target=vagrant
```

## Notes

This repository takes input and inspiration from a handful of community projects. The authors would like to thank: [@ansible-community](https://github.com/ansible-community) in particular.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/operatehappy/packer-nomad/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
