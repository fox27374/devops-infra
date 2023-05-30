terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
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
