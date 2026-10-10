variable "project_name" {
  description = "enter the project name"
  type = string
}

variable "environment" {
  description = "enter the environment in which you are working"
  type = string
}

variable "vpc_cidr" {
  description = "enter the cidr range of the vpc"
  type = string
}


variable "public_subnets" {
  description = "Enter the availability zone and cidr block range of the public subnet"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "private_app_subnets" {
  description = "Enter the availability zone and cidr block range of the private app subnet"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "private_db_subnets" {
  description = "Enter the availability zone and cidr block range of the private db subnet"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}


