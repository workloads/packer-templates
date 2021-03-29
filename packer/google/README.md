# Google Cloud

## Table of Contents

- [Google Cloud](#google-cloud)
  - [Overview](#overview)
  - [Authentication](#authentication)
  - [Prerequisites](#prerequisites)
  - [Images](#images)

## Overview

> image template: [image.pkr.hcl](image.pkr.hcl)
> image variables: [variables.pkr.hcl](variables.pkr.hcl)
> build target: `google`
> build command: `make build target=google`

> `make` commands must be run from the root directory.

## Authentication

Packer (and Terraform) requires authentication credentials to interact with Google Cloud APIs.

The Google workflow is set up to use the Google Cloud CLI `gcloud` login information to retrieve these credentials.

To log in, execute the `gcloud auth login` command and follow the instructions presented by the application.

> ⚠️ You will need to log in to a Google Cloud account that has permissions to create Projects, Virtual Machines, and Virtual Machine Images.

## Prerequisites

> init command `make terraform-init target=google`
> build command: `make terraform-apply target=google`
> destroy command: `make terraform-destroy target=google`

> `make` commands must be run from the root directory.

## Images

not yet available
