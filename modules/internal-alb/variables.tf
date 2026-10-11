variable "project_name" {
  description = "enter the name of the project"
  type = string
}

variable "environment" {
  description = "enter the environment in which you are working on " 
  type = string
}

variable "vpc_id" {
  description  = "enter the vpc id where the internal load balancer will be created"
  type = string
}

variable "private_app_subnet_ids" {
  description = "Private application subnet ids"
  type  = map(string)
}

variable "internal_alb_security_group_id" {
  description = "Security group id for the internal loadbalancer"
  type = string
}



