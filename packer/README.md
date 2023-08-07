# Packer Templates

This directory contains templates for various providers.

All templates inherit [`shared_variables.pkr.hcl`](./shared_variables.pkr.hcl) through a symbolic link

## Making shared variables accessible to a template

The global [`shared_variables.pkr.hcl`](./shared_variables.pkr.hcl) file contains variables that are shared across all templates.

To make these variables accessible to a template, the `_link_vars` target inside the [Makefile](../Makefile) can be used:

```shell
make _link_vars target=<target>
 ```
