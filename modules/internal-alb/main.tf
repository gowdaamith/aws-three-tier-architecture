resource "aws_lb" "internal" {
  name = "${var.project_name}-${var.environment}-internal-alb"
  internal = true
  load_balancer_type = "application" 
  security_groups = [var.internal_alb_security_group_id]
  subnets = values(var.private_app_subnet_ids)
  enable_deletion_protection = false
  tags = {
    name = "${var.project_name}-${var.environment}-internal-alb"
    environment = var.environment
    project = var.project_name
  }
}

resource "aws_lb_target_group" "backend" {
  name = "${var.project_name}-${var.environment}-app-tg"
  port = 5000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance" 
    
  health_check {
    enabled = true
    path = "/live`"
    protocol = "HTTP" 
    port = "traffic-port"
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 5
    interval = 30
    matcher = "200"
 }
 tags = {
    Name        = "${var.project_name}-${var.environment}-backend-tg"
    Environment = var.environment
    Project     = var.project_name
  }
}
 
resource "aws_lb_listener" "http"{
  load_balancer_arn = aws_lb.internal.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-internal-listener"
  }

}




 
