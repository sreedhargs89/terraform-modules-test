provider "aws" {
  region = var.aws_region
}


module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
  prefix     = ""
}

module "subnet" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  prefix            = ""
}

module "s3" {
  source = "./modules/s3"
  acl    = var.s3_acl
  tag_prefix = "sree"
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  prefix        = "sree"
  tag_prefix    = "sree"
}
