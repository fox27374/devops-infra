# Linux Training Environment

# General variables
GEN = {
  region = "eu-west-1"
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
  lb_dns_fqdn        = "lab.aws.ntslab.eu"
  guacamole_dns_fqdn = "guacamole.aws.ntslab.eu"
  bastion_dns_fqdn   = "bastion.aws.ntslab.eu"
  dns_zone_id        = "Z04324152F8LEAJFJOZTE"
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
  lab_ami               = "ami-0a422d70f727fe93e"
  lab_instance_type     = "t3.medium"
  lab_name              = "lab"
  lab_count             = 1
  bastion_name          = "bastion"
}
