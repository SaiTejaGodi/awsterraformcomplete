
output "vpc_id" {
  value = module.networking.vpc_id
}

output "ec2_public_ip" {
  value = module.compute.ec2_public_ip
}
