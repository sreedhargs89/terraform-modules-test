variable "acl" {
  description = "S3 bucket ACL"
  type        = string
}

variable "tag_prefix" {
  description = "Resource name prefix"
  type        = string
  default = "sree"
}
