terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.81.0"
    }
  }

  # backend "s3" {
  #   bucket         = "nts-dkofler-tf-state-github"
  #   key            = "state/terraform.tfstate"
  #   region         = "eu-west-1"
  #   encrypt        = true
  #   dynamodb_table = "devops-infra_tf_lockid"
  #   profile        = "nts"
  # }

  required_version = ">= 1.2.0"
}

# Generalvariables
variable "GEN" {
  type = map(any)
}

# Network variables
variable "NW" {
  type = map(any)
}

# Security variables
variable "SEC" {
  type = map(any)
}

# EC2 variables
variable "EC2" {
  type = map(any)
}

provider "aws" {
  region  = var.GEN["region"]
  profile = "nts"
}
