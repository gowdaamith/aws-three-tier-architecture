variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "private_app_subnet_ids" {
  description = "Private application subnet IDs"
  type        = map(string)
}

variable "app_security_group_id" {
  description = "Security group ID for backend EC2 instances"
  type        = string
}

variable "backend_target_group_arn" {
  description = "ARN of the internal ALB backend target group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for the backend EC2 instances"
  type        = string
}

variable "docker_image" {
  description = "Docker image containing the Node.js backend"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of backend EC2 instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of backend instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of backend instances"
  type        = number
  default     = 4
}

variable "database_host" {
  description = "RDS PostgreSQL endpoint hostname"
  type        = string
}

variable "database_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "database_username" {
  description = "PostgreSQL database username"
  type        = string
}

variable "database_secret_arn" {
  description = "Secrets Manager ARN containing the database credentials"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
