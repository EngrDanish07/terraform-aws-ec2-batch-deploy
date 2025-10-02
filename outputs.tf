output "public_ips" {
  description = "Public IP addresses of all EC2 instances"
  value = {
    for name, instance in aws_instance.multi_ec2 :
    name => instance.public_ip
  }
}

output "private_ips" {
  description = "Private IP addresses of all EC2 instances"
  value = {
    for name, instance in aws_instance.multi_ec2 :
    name => instance.private_ip 
  }
}

output "public_dns" {
  description = "Public DNS hostnames of all EC2 instances"
  value = {
    for name, instance in aws_instance.multi_ec2 :
    name => instance.public_dns
  }
}
#for k, v in map : k => v.some_property
