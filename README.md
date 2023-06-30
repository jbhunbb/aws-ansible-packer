AWS 에서 Ansible + Packer 를 사용하여 이미지 자동배포
================================

사용 이유
----------
새로운 릴리즈가 일어날 때마다 멀티클라우드 환경에 릴리즈된 이미지를 업로드했어야 했고, 관리가 되지 않아 Ansible 및 Packer를 사용한 이미지 관리 방안을 수립하기 위해 사용합니다.
  
AS-IS
-----
기존에 최신 업데이트된 이미지를 각 멀티클라우드 환경의 이미지 서비스를 사용하여 이미지 업로드 진행  
AWS나 멀티클라우드 환경에 업로드되지 않을 경우 과거의 이미지를 사용하여 서비스를 구축하고, 구축한 뒤 **릴리즈 노트를 수시로 확인하여 수정**을 수동으로 진행

TO-BE
-----
새로운 변경사항에 대해 Ansible의 playbook에 반영하여 수정하면, 자동으로 멀티클라우드 환경에 이미지를 생성하기위한 인스턴스 생성 그리고 그에 대한 이미지를 생성, 그리고 이미지를 생성하기 위한 인스턴스 삭제까지 진행되면서 이미지 관리가 훨씬 간편화됨.

---

목표
--------
첫 번째 목표: Ansible을 활용한 SSH Root/Password Login 설정, iptables 설정, nginx 설치까지 완료 후 이미지 패킹해서 AMI 로 저장
두 번째 목표: openssl 업데이트 후 기존 이미지 업데이트하기

### 사전 설정
* AWS CLI 설치: [AWS-CLI Install Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#cliv2-linux-install)
* Packer 설치: [HashiCorp Packer Install Guide](https://developer.hashicorp.com/packer/downloads)
* Ansible 설치: [Ansible Install Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

---

