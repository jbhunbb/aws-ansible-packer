locals {
  date = formatdate("YYYYDDMM", timestamp())
  image_name = "base-image-${local.date}"
}

variable "linode_region" {
  type = string
  default = "ap-northeast" 
}

variable "linode_api_key" {
  type = string
  default = env("LINODE_API_KEY")
}

variable "aws_region" {
  type = string
  default = "ap-northeast-1"
}

variable "ssh_passwd" {
  type = string
  default = env("SSH_PASSWD")
}