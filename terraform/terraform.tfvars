# Linux Training Environment

# General variables
GEN = {
  region = "eu-west-1"
}

# Network variables
NW = {
  vpc_name        = "devops-infra"
  vpc_cidr        = "10.42.22.0/25"
  sn_private_cidr = "10.42.22.0/26"
  sn_private_name = "private"
  sn_public_cidr  = "10.42.22.64/26"
  sn_public_name  = "public"
  dns_fqdn        = "lab.aws.ntslab.eu"
  dns_zone_id     = "Z04324152F8LEAJFJOZTE"
}

# Security variables
SEC = {
  sg_public_name  = "public"
  sg_private_name = "private"
}

# EC2 variables
EC2 = {
  bastion_ami           = "ami-0a422d70f727fe93e" # Ubuntu 22.04
  bastion_instance_type = "t3.medium"
  docker_ami            = "ami-0a422d70f727fe93e"
  docker_instance_type  = "t3.medium"
  docker_name           = "docker"
  k8s_ami               = "ami-0a422d70f727fe93e"
  k8s_instance_type     = "t3.medium"
  docker_count          = 1
  k8s_count             = 1
  k8s_name              = "k8s"
  bastion_name          = "bastion"
}
