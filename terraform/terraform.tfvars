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
  instance_type = "t2.micro"
  bastion_ami   = "ami-096800910c1b781ba" # Ubuntu
  student_ami   = "ami-096800910c1b781ba" # Splunk Enterprise
  private_count = 1
  lab_count     = 0
  student_name  = "student"
  bastion_name  = "bastion"
}
