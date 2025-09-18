variable "vpc_id" {
  description = "VPC ID for the subnet"
  type        = string
}

variable "cidr_block" {
  description = "Subnet CIDR block"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}
