# AWS Cloud Provider
provider "aws" {
  region = var.region
}

# Modules

module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
  Pub_Sub_01_cidr = var.Pub_Sub_01_cidr
  Pub_Sub_02_cidr = var.Pub_Sub_02_cidr
  App_Sub_01_cidr = var.App_Sub_01_cidr
  App_Sub_02_cidr = var.App_Sub_02_cidr
  DB_Sub_01_cidr = var.DB_Sub_01_cidr
  DB_Sub_02_cidr = var.DB_Sub_02_cidr
}
