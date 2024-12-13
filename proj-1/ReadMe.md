

#-----------------------------



cd terraform/project-1
terraform init
terraform plan -out=tfplan
terraform apply tfplan

terraform plan -destroy
terraform destroy -auto-approve


#-----------------------------

Idea:
![alt text](pics/image.png)

State:
- Modular testing starting with VPC

#-----------------------------

Structure:

- VPC
- IGW
- Route Table
    destinationCidrBlock: '0.0.0.0/0'
    Target: IGW
- Security Group
    HTTP inbound only

- Subnet public in 
    AZ1
        cidrBlock: '10.0.1.0/24
        Associate with route table
    AZ2
        cidrBlock: '10.0.4.0/24
        Associate with route table

- 


#-----------------------------

