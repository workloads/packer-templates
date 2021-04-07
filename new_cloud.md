# To add a new cloud image (AWS)

When adding a new cloud, there are several steps you need to take. Before starting, ask yourself the following two questions:

*Do we need to stand up additional/pre-requisite resources before being able to run Packer?*

- If so, create a folder under `terraform` that creates the needed resources.

*What are the needed variables for Packer to run correctly?*

- Check the Packer [builder](https://www.packer.io/docs/builders) docs.

## Prerequisites

* AWS comes with a default VPC for you to launch packer into. If you are part of a corporate network, you may need to
run this in a non-default VPC with an Internet Gateway (IGW) that connects to the public internet.

* `<cloud>-credentials.auto.pkrvars.hcl` - Used to populate Packer with your local cli credentials for your cloud
provider

## Steps

### Create the needed files

1. Create a new directory under `packer/`.
1. Create a `<cloud>-credentials.auto.pkrvars.hcl.sample` file for documentation.
1. Create a `<cloud>-credentials.auto.pkrvars.hcl` file for your actual Packer run.
   1. Optionally - Populate the credentials file with the values you intend to use.
1. Create a `variables.pkr.hcl` for the variables needed for the Packer run. This is similar to Terraform's `variables.tf` file.
1. Create a new `image.pkr.hcl` file. This is similar to Terraform's `main.tf` file.
1. Create a `vals.pkrvars.hcl` file. This is similar to an `override.json` and will be populated with values for the variables defined in `variables.pkr.hcl`.

#### Shell Commands

Replace the `<cloud>` below with your builder name.

```shell
CLOUD=<cloud>
mkdir -p packer/$CLOUD ;
cd packer/$CLOUD ;
touch \
$CLOUD-credentials.auto.pkrvars.hcl.sample \
$CLOUD-credentials.auto.pkrvars.hcl \
variables.pkr.hcl \
image.pkr.hcl \
vals.pkrvars.hcl;
cd ../..
```

### Populate files

1. Go to the needed [builder](https://www.packer.io/docs/builders) page. Search for "Basic Example" and paste that into `image.pkr.hcl`.
   1. Replace every hardcoded value with `var.<variable_name>`
   2. Move the hardcoded values to `vals.pkrvars.hcl`
2. Start filling out the `variables.pkr.hcl` for the needed example image.
   1. For every `var.<variable_name>`, create a [variable definition](https://www.packer.io/guides/hcl/variables).
3. Start filling out `vals.pkrvars.hcl`, or update it with the values for the variables you actually want.
4. Populate the `<cloud>-credentials.auto.pkrvars.hcl` file with your credentials if you have not done so.

### Run Packer with Make

1. Return to the root of the repository
2. Run `make lint target=$CLOUD`
3. Run `make build target=$CLOUD`
