regions = ["eu-central-1"] // regions = ["eu-central-1", "eu-west-1"]

public_subnet_configs = [
  { availability_zone = "eu-central-1a", cidr_block = "10.0.1.0/24" } // ,
  //{ availability_zone = "eu-central-1b", cidr_block = "10.0.4.0/24" }
]

private_subnets = [
  "subnet-0a1b2c3d", "subnet-0b1c2d3e"
]

