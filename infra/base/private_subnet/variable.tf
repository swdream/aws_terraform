variable "vpc_id" {
  default = ""
}

variable "nat_gateway_id" {
  default = ""
}

variable "private_subnet_name" {
  default = "private"
}

variable "private_subnet_cidrs" {
  default = "10.0.3.0/24"
}

variable "azs" {
  default = " "
}
