#-------------------------------------------------------------+
# This module creates all resources necessary for a private.  |
# subnet                                                      |
#-------------------------------------------------------------+


resource "aws_subnet" "private" {
  vpc_id                          = "${var.vpc_id}"
  cidr_block                      = "${element(split(",", var.private_subnet_cidrs), count.index)}"
  availability_zone               = "${element(split(",", var.azs), count.index)}"
  count                           = "${length(split(",", var.private_subnet_cidrs))}"
  tags { 
    Name                          = "${var.private_subnet_name}.${element(split(",", var.azs), count.index)}" 
    }
  lifecycle { 
    create_before_destroy = true 
  }
}

resource "aws_route_table" "private" {
  vpc_id                                  = "${var.vpc_id}"
  #count                                  = "${length(split(",", var.private_subnet_cidrs))}"
  route {
    cidr_block                            = "0.0.0.0/0"
    nat_gateway_id                        = "${var.nat_gateway_id}"
  }
  tag { 
    Name                                  = "${var.private_subnet_name}.${element(split(",", var.azs), count.index)}" 
  }
  lifecycle { 
    create_before_destroy                 = true 
  }
}

resource "aws_route_table_association" "private" {
  count                                   = "${length(split(",", var.private_subnet_cidrs))}"
  subnet_id                               = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id                          = "${element(aws_route_table.private.*.id, count.index)}"
  lifecycle { 
    create_before_destroy                 = true 
  }
}
