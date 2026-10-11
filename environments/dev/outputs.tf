output "vpc_id" {
  description = "vpc_id"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "public subnet ids"
  value       = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "Private application subnet IDs"
  value       = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "Private database subnet IDs"
  value       = module.vpc.private_db_subnet_ids
}

output "public_alb_sg_id" {
  description = "sg id of the public alb sg "
  value       = module.security_groups.public_alb_sg_id
}

output "web_sg_id" {
  description = "sg id of the web sg"
  value       = module.security_groups.web_sg_id
}

output "internal_alb_sg_id" {
  description = "sg id of the internal alb sg"
  value       = module.security_groups.internal_alb_sg_id
}

output "app_sg_id" {
  description = "sg id of the app sg"
  value       = module.security_groups.app_sg_id
}

output "database_sg_id" {
  description = "sg id of the database sg"
  value       = module.security_groups.database_sg_id
}


output "db_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.db_endpoint
}

output "db_address" {
  description = "RDS hostname"
  value       = module.rds.db_address
}

output "db_port" {
  description = "RDS port"
  value       = module.rds.db_port
}

output "db_name" {
  description = "Application database name"
  value       = module.rds.db_name
}

output "internal_alb_dns_name" {
  description = "Private DNS name of the internal ALB"
  value       = module.internal_alb.internal_alb_dns_name
}

output "backend_target_group_arn" {
  description = "Backend target group ARN"
  value       = module.internal_alb.backend_target_group_arn
}



