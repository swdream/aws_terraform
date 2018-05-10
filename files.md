

# Files list

- filename.tf (named as you want, just make sense, affect nothing)
- variables.tf
- terraform.tfvars
- output.tf
- terraform.tfstate

# filename.tf

Terraform configuration file which configures your infrastructure. It combines the information to setup your components such as vpc, subnet, instances ...
The syntax of Terraform configurations is called HashiCorp Configuration Language (HCL).

For example

```
resource "aws_instance" "web" {
  ami               = "${var.ami}"
  count             = 2
  source_dest_check = false

  connection {
    user = "root"
  }
}
```

Terraform also supports reading JSON formatted configuration files

```
{
  "variable": {
    "ami": {
      "description": "the AMI to use"
    }
  },

  "resource": {
    "aws_instance": {
      "web": {
        "ami": "${var.ami}",
        "count": 2,
        "source_dest_check": false,

        "connection": {
          "user": "root"
        }
      }
    }
  }
}
```

The downsides of JSON are less human readability and the lack of comments. So we often use HCL syntax.

# variables.tf

Variable configuration file where stores variable serve as parameter for a Terraform module.
For example:

```
variable "key" {
  type = "string"
}

variable "images" {
  type = "map"

  default = {
    us-east-1 = "image-1234"
    us-west-2 = "image-4567"
  }
}

variable "zones" {
  default = ["us-east-1a", "us-east-1b"]
}

```

For more information, refer to [variables](https://www.terraform.io/docs/configuration/variables.html)

# terrrafrom.tfvars
Store value of variables in `variables.tf` file. It will be referenced in configuration files using ${var.variable_name}
For example:

```
vpc_id = "vpc_test"
```

# output.tf
Outputs configuration file where define value that will be highlighted to the users when terraform applies.

## Syntax

```
output NAME {
  value = VALUE
}
```

For example:

```
output "address" {
  value = "${aws_instance.db.public_dns}"
}
```

### Sensitive Outputs

Set `sensitive = true`

```
output "sensitive" {
  sensitive = true
  value     = VALUE
}
```

Sensitive outputs will be showed `<sensitive>` as its value when we run `terraform appy` or `terraform refresh``.

# terraform.tfstate

Store state of your infrastructure. This file will be created after first time you run `terraform aplly` to build your infrastructure.
