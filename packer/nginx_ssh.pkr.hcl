packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-2" {
  ami_name = "amazon-linux-2-nginx"
  instance_type = "t3.micro"
  region        = "ap-northeast-1"
  force_deregister = true
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.0.*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}


build {
  name    = "dev2-ansible-packer"
  sources = [
    "source.amazon-ebs.amazon-2"
  ]
  provisioner "shell" {
    inline = [
      "sudo amazon-linux-extras install nginx1"
    ]
  }
}