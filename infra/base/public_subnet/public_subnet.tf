#----------------------------------------------------------+
# This module creates all resources necessary for a public |
# subnet                                                   |
#----------------------------------------------------------+

resource "aws_subnet" "public" {
  vpc_id                            = "${var.vpc_id}"
  cidr_block                        = "${split(",", var.public_subnet_cidrs)}"
  availability_zone                 = "${split(",", var.azs)}"
  tags { 
    Name                            = "${var.public_subnet_name}  
  }
  lifecycle { 
    create_before_destroy = true 
  }
  map_public_ip_on_launch           = true
}

resource "aws_route_table" "public" {
  vpc_id                            = "${var.vpc_id}"
  route {
      cidr_block                    = "0.0.0.0/0"
      gateway_id                    = "${var.gateway_id}"
  }
  tags { Name                       = "${var.public_subnet_name}
}

resource "aws_route_table_association" "public" {
  subnet_id                         = "${aws_subnet.public.id}"
  route_table_id                    = "${aws_route_table.public.id}"
}
