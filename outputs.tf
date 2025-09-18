output "s3_bucket_id" {
  value = module.s3.bucket_id
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.subnet.subnet_id
}
