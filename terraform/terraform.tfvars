# Linux Training Environment

# General variables
GEN = {
  region = "eu-west-1"
}

# EC2 variables
EC2 = {
  bastion_ami           = "ami-0bc691261a82b32bc" # Ubuntu 24.04 x86
  bastion_instance_type = "t3.medium"             # x86
  bastion_name          = "bastion"
  splunk_ami            = "ami-0bc691261a82b32bc" # Ubuntu 24.04 x86
  splunk_instance_type  = "t3.medium"             # x86
  splunk_volume_size    = "100"
  splunk_name           = "splunk"
  lab_ami               = "ami-0bc691261a82b32bc"
  lab_instance_type     = "t3.medium"
  lab_name              = "lab"
  lab_count             = 1
  lab_volume_size       = "30"
}

# Network variables
NW = {
  vpc_name           = "devops-infra"
  vpc_cidr           = "10.42.22.0/25"
  sn_private_cidr    = "10.42.22.0/26"
  sn_private_name    = "private"
  sn_public_cidr     = "10.42.22.64/26"
  sn_public_name     = "public"
  external_v4_cidr   = "0.0.0.0/0"
  external_v6_cidr   = "::/0"
  az1                = "eu-west-1a"
  az2                = "eu-west-1b"
  dns_zone_id        = "Z04324152F8LEAJFJOZTF"
  domain_name        = "kofler.sh"
}

# Security variables
SEC = {
  sg_public_name  = "public"
  sg_private_name = "private"
}

