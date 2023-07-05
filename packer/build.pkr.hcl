packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
    linode = {
      version = ">= 1.0.1"
      source  = "github.com/linode/linode"
    }
  }
}

# Linode 이미지 설정
source "linode" "ubuntu" {
  image             = "linode/ubuntu22.04"
  image_description = "acker TEST Image"
  image_label       = "${local.image_name}"
  instance_label    = "ubuntu-base-instance"
  instance_type     = "g6-standard-1"
  linode_token      = var.linode_api_key
  region            = var.linode_region
  root_pass         = var.ssh_passwd
  ssh_username      = "root"
}

# AWS 이미지 설정
source "amazon-ebs" "ubuntu" {
  ami_name = "${local.image_name}"
  instance_type = "t3.micro"
  region        = var.aws_region
  force_deregister = true
  tags = {
    Name = "${local.image_name}"
  }
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ubuntu"
}

# 이미지 생성 전, 인스턴스에 설정할 사항 작성 (빌드라고 칭함)
build {
  sources = [
    "source.amazon-ebs.ubuntu",
    "source.linode.ubuntu"
  ]
  provisioner "ansible" {
    playbook_file = "./ansible/playbook.yml"
  }
}