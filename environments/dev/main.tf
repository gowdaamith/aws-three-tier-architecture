module "vpc" {
  source              = "../../modules/vpc"
  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnets      = var.public_subnets
  private_app_subnets = var.private_app_subnets
  private_db_subnets  = var.private_db_subnets
}

module "security_groups" {
  source       = "../../modules/security-group"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source = "../../modules/rds"

  project_name               = var.project_name
  environment                = var.environment
  database_subnet_id         = module.vpc.private_db_subnet_ids
  database_security_group_id = module.security_groups.database_sg_id

  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  backup_retention_period = var.db_backup_retention_period

  multi_az = var.db_multi_az
}

module "internal_alb" {
  source                         = "../../modules/internal-alb"
  project_name                   = var.project_name
  environment                    = var.environment
  vpc_id                         = module.vpc.vpc_id
  private_app_subnet_ids         = module.vpc.private_app_subnet_ids
  internal_alb_security_group_id = module.security_groups.internal_alb_sg_id
}


