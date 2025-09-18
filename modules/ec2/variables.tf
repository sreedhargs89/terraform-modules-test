variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
  default = "ami-03f4878755434977f"

}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "tag_prefix" {
  description = "Tag prefix for resource naming"
  type        = string
}

