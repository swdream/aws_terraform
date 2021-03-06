#------------------------------------#
# Create necessary resources for VPC #
#------------------------------------#

resource "aws_vpc" "vpc" {
  cidr_block              = "${var.vpc_cidr}"
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags  {
    Name                  = "${var.vpc_name}"
}
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "public" {
  vpc_                    = "${aws_vpc.vpc.id}"
  tags {
    Name                  = "${var.vpc_name}"
  }
}
