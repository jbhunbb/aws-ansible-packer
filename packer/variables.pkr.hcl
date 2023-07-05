# 이미지 이름에 날짜를 넣기 위해 locals - formatdate, timestamp 함수 활용
locals {
  date = formatdate("YYYYMMDD", timestamp())
  image_name = "base-image-${local.date}"
}

# 이미지/인스턴스를 생성할 Linode Region 설정
variable "linode_region" {
  type = string
  default = "ap-northeast" 
}

# 환경변수 LINODE_API_KEY를 읽어와서 linode_api_key 변수에 저장
variable "linode_api_key" {
  type = string
  default = env("LINODE_API_KEY")
}

# 이미지/인스턴스를 생성할 AWS Region 설정
variable "aws_region" {
  type = string
  default = "ap-northeast-1"
}

# 환경변수 SSH_PASSWD를 읽어와서 ssh_passwd 변수에 저장
variable "ssh_passwd" {
  type = string
  default = env("SSH_PASSWD")
}