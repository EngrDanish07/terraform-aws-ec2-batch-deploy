variable "ec2_instances" {
  description = "Map of EC2 instances to create. Each key represents an instance name with its own AMI and instance type."

  type = map(object({
    ami           = string
    instance_type = string
  }))

  default = {
    web-01 = {
      ami           = "ami-03aa99ddf5498ceb9"
      instance_type = "t3.micro"
    },
    web-02 = {
      ami           = "ami-03aa99ddf5498ceb9"
      instance_type = "t3.small"
    },
    web-03 = {
      ami           = "ami-03aa99ddf5498ceb9"
      instance_type = "t3.micro"
    }
  }
}
