variable "tag_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "sree"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_ami" {
  description = "AMI ID for EC2"
  type        = string
  default     = "ami-03f4878755434977f"
}

variable "ec2_instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "s3_acl" {
  description = "ACL for S3 bucket"
  type        = string
  default     = "private"
}
