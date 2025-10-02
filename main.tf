# Key Pair for SSH access
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# Use default VPC (for demo/test purposes)
resource "aws_default_vpc" "default" {
  
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Security group for EC2 instance"
  vpc_id      = aws_default_vpc.default.id
}

# Allow SSH (port 22)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow SSH access"
  ip_protocol       = "tcp"
}

# Allow HTTP (port 80)
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTP traffic"
  ip_protocol       = "tcp"
}

# Allow HTTPS (port 443)
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTPS traffic"
  ip_protocol       = "tcp"
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
  ip_protocol       = "-1"
}

# Launch multiple EC2 instances
resource "aws_instance" "multi_ec2" {
  for_each = var.ec2_instances

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = aws_key_pair.ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("simple_web.sh")

  tags = {
    Name = each.key
  }

  depends_on = [aws_security_group.ec2_sg]
}