# Template: `null`

## Table of Contents

<!-- TOC -->
* [Template: `null`](#template-null)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
  * [Usage](#usage)
  * [Notes](#notes)
<!-- TOC -->

## Requirements

- Packer `1.9.1` or newer

## Overview

|                 |                                      |
|-----------------|--------------------------------------|
| image template  | [template.pkr.hcl](template.pkr.hcl) |
| image variables | n/a                                  |
| build target    | `null`                               |
| build command   | `make build target=null os=<os>`     |
| lint command    | `make lint target=null os=<os>`      |

## Usage

To build the `null` image for the `my_os` operating system, run:

```shell
make build target=null os=my_os
```

## Notes

* The `null` template does not produce an output image but it does render configuration information in the `$(DIR_DIST)` directory.
