resource "aws_eip" "nat_gateway" {
  vpc                               = true
  lifecycle {
    create_before_destroy           = true 
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id                     = "${aws_eip.nat_gateway.id}"
  subnet_id                         = "${var.subnet_id}"
  lifecycle { 
     create_before_destroy = true
  }
}
