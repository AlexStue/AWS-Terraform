

#-----------------------------



cd terraform/project-1
terraform init

terraform plan
terraform apply
terraform apply -var-file="dev.tfvars"

#-----------------------------

Idea:
![alt text](pics/image.png)

State:
- Multiple regions combined with "Global Accelerator"
- Without EC2 AutoScaling
- Without DB
- Without EFS

#-----------------------------

/terraform-infrastructure
│
├── /modules                        # Reusable infrastructure modules
│   ├── /vpc                        # Module for creating VPC, subnets, and routing
│   │   ├── main.tf                 # Main resources for the VPC module
│   │   ├── variables.tf            # Variables used in the VPC module
│   │   ├── outputs.tf              # Outputs from the VPC module
│   │   └── terraform.tfvars        # Optional, specific variable values for the VPC module
│   │
│   ├── /security_group             # Module for creating security groups
│   │   ├── main.tf                 # Main resources for the Security Group module
│   │   ├── variables.tf            # Variables used in the Security Group module
│   │   ├── outputs.tf              # Outputs from the Security Group module
│   │   └── terraform.tfvars        # Optional, specific variable values for the Security Group module
│   │
│   ├── /nat_gateway                # Module for creating NAT Gateways
│   │   ├── main.tf                 # Main resources for the NAT Gateway module
│   │   ├── variables.tf            # Variables used in the NAT Gateway module
│   │   ├── outputs.tf              # Outputs from the NAT Gateway module
│   │   └── terraform.tfvars        # Optional, specific variable values for the NAT Gateway module
│   │
│   ├── /load_balancer              # Module for creating Load Balancer (ALB)
│   │   ├── main.tf                 # Main resources for the Load Balancer module
│   │   ├── variables.tf            # Variables used in the Load Balancer module
│   │   ├── outputs.tf              # Outputs from the Load Balancer module
│   │   └── terraform.tfvars        # Optional, specific variable values for the Load Balancer module
│   │
│   ├── /global_accelerator         # Module for creating Global Accelerator
│   │   ├── main.tf                 # Main resources for the Global Accelerator module
│   │   ├── variables.tf            # Variables used in the Global Accelerator module
│   │   ├── outputs.tf              # Outputs from the Global Accelerator module
│   │   └── terraform.tfvars        # Optional, specific variable values for the Global Accelerator module
│   │
│   └── /ec2_instance               # Module for creating EC2 Instances
│       ├── main.tf                 # Main resources for the EC2 Instance module
│       ├── variables.tf            # Variables used in the EC2 Instance module
│       ├── outputs.tf              # Outputs from the EC2 Instance module
│       └── terraform.tfvars        # Optional, specific variable values for the EC2 Instance module
│
├── /project                        # Root project directory
│   ├── main.tf                     # Main Terraform configuration to use the modules
│   ├── variables.tf                # Root-level variables
│   ├── terraform.tfvars            # Root-level variable values (environment-specific)
│   ├── outputs.tf                  # Outputs from the root-level configuration
│   ├── /network-stack.tf           # Network stack (you can put custom logic or configurations here)
│   ├── /providers.tf               # Provider configurations (AWS, etc.)
│   ├── /backend.tf                 # Backend configuration for remote state (e.g., S3, DynamoDB)
│   └── /state                      # Directory to store the Terraform state file (if not using remote state)


#-----------------------------

