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
}

# Security variables
SEC = {
  sg_public_name  = "public"
  sg_private_name = "private"
}

# EC2 variables
EC2 = {
  bastion_ami   = "ami-0a422d70f727fe93e" # Ubuntu 22.04
  bastion_instance_type = "t3.micro"
  student_ami   = "ami-0a422d70f727fe93e"
  student_instance_type = "t3.medium"
  private_count = 10
  lab_count     = 0
  student_name  = "student"
  bastion_name  = "bastion"
}
