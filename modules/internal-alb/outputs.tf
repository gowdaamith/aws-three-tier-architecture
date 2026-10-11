output "internal_alb_arn" {
  description = "ARN of the internal Application Load Balancer"
  value       = aws_lb.internal.arn
}

output "internal_alb_dns_name" {
  description = "DNS name of the internal Application Load Balancer"
  value       = aws_lb.internal.dns_name
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend.arn
}

output "internal_alb_listener_arn" {
  description = "ARN of the internal ALB HTTP listener"
  value       = aws_lb_listener.http.arn
}
