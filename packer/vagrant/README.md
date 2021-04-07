# HashiCorp Vagrant

## Table of Contents

- [HashiCorp Vagrant](#hashicorp-vagrant)
  - [Overview](#overview)
  - [Vagrant](#vagrant)
  - [Vagrant Cloud](#vagrant-cloud)

## Overview

> image template: [.image.pkr.hcl](image.pkr.hcl)

> image variables: [.variables.pkr.hcl](variables.pkr.hcl)

> build target: `vagrant`

> build command: `make build target=vagrant`

> `make` commands must be run from the root directory.

## Vagrant

> build target `vagrant`

## Vagrant Cloud

Vagrant Cloud is a subset of the [Vagrant](#vagrant) build process and cannot be executed as a stand-alone build-process.

To enable building for and deploying to [Vagrant Cloud](https://app.vagrantup.com/), open [image.pkr.hcl](image.pkr.hcl).

Then, uncomment the Vagrant Cloud-specific `post-processor` (near the bottom of the file) and execute a build targetted at `vagrant`:

```sh
make build target=vagrant
```

> `make` commands must be run from the root directory.
