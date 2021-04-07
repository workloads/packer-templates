# Configuration Strategies for AWS

This document seeks to track alternative ways to leverage the patterns followed in this repo. In several places, there are intentional design choices to include or omit specific functionality. Those choices are tracked here.

## Using Filter Blocks for Builder locations

Packer has to make a decision where to run the instance in AWS. By default, the default VPC is used. Since some organizations delete this, the most minimal set up for a building a Packer image inside a non-default VPC is to provide `subnet_id`. Alternatively, you can use the [`subnet filter block`](https://www.packer.io/docs/builders/amazon/ebs#subnet_filter) to select a subnet on a predetermined strategy, rather than a hardcoded value. The filter block expects your strategy to return exactly one result. In the example below, the subnet filter will look for all subnets with the tag key:value of `"Class": "build"`.

*Note:* `vpc_id` is not required at all, as it is inferred from the `subnet_id`.

```hcl
  subnet_filter {
    filters = {
      "tag:Class": "build"
    }
    most_free = true
    random = false
  }
```

## Test your configuration runs without publishing your AMI

Add the following line to your `image.pkr.hcl` in the `source "amazon-ebs" "image"` stanza.

```hcl
skip_create_ami            = true
```
