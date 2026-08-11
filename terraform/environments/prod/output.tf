output "instance_id" {
  description = "Prod EC2 instance ID"
  value       = module.aws_infrastructure.instance_id
}

output "public_ip" {
  description = "Prod EC2 public IP"
  value       = module.aws_infrastructure.public_ip
}

output "public_dns" {
  description = "Prod EC2 public DNS"
  value       = module.aws_infrastructure.public_dns
}

output "security_group_id" {
  description = "Prod security group ID"
  value       = module.aws_infrastructure.security_group_id
}