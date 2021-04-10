# Amazon Web Services

## Table of Contents

- [Amazon Web Services](#amazon-web-services)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Overview](#overview)
  - [Authentication](#authentication)
  - [Images](#images)

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
