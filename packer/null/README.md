# Template: `null`

## Table of Contents

<!-- TOC -->
* [Template: `null`](#template-null)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Overview](#overview)
  * [Usage](#usage)
    * [Inputs](#inputs)
  * [Notes](#notes)
<!-- TOC -->

## Requirements

- Packer `1.9.1` or newer

## Overview

|                 |                                  |
|-----------------|----------------------------------|
| image template  | n/a                              |
| image variables | n/a                              |
| build target    | `null`                           |
| build command   | `make build target=null os=<os>` |
| lint command    | `make lint target=null os=<os>`  |

## Usage

To build the `null` image for the `my_os` operating system, run:

```shell
make build target=null os=my_os
```

## Notes

* The `null` template does not produce an output image; it is meant for rapid-prototyping of the `shared` variables concept.
