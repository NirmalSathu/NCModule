variable "region" {
	default = "eu-central-1"
}

variable "vpc_cidr" {
	default = "10.1.0.0/16"
}

variable "Pub_Sub_01_cidr" {
	default = "10.1.0.0/23"
}

variable "Pub_Sub_02_cidr" {
	default = "10.1.2.0/23"
}

variable "App_Sub_01_cidr" {
	default = "10.1.4.0/23"
}

variable "App_Sub_02_cidr" {
	default = "10.1.6.0/23"
}

variable "DB_Sub_01_cidr" {
	default = "10.1.8.0/23"
}

variable "DB_Sub_02_cidr" {
	default = "10.1.10.0/23"
}

variable "account-id" {
	default = "XXXXX"
}

variable "log-group-name" {
	default = "nordcloudtest-flow-logs"
}

variable "s3-bucket" {
	default = "nordcloudtest-tf-state"
}