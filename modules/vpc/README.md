# Terraform module to deploy VPC 
This terraform module deploys VPC and all related services in any AWS account such as Subnets, NAT, IGW, etc. 

## Prerequisites
- Terraform 0.15 
Here are the [Installation instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- AWS account IAM access and secret key with sufficient right to deploy all services related to VPC

## Directory structure
`data.tf` - Is responsible to pick your current AWS region and availibility zone to feed to other steps in the automation <br/>
`main.tf` - Is main file and responsible to do all heavy work for you, setting up VPC, subnets, NAT, IGW, route table and create appropriate routes to be used in a VPC <br/>
`provider.tf` - Is provider for telling Terraform to use AWS provider and connect with your account using IAM keys <br/>
`output.tf` - Is responsible to print out important informations such as VPC ID, public, and private Subnet IDs that may be used in your CloudFormation stack as input <br/>
`variables.tf` - Is responsible to take inputs from users and some default CIDR blocks to properly setup VPC for you <br/>

## How to use guide
Deploying VPC and componets needed for it is super simple using Terraform. Make sure you have prerequisites installed and folllow below steps: 

Cd to VPC directory 
```
cd vpc
```

Initiate terraform 
```
terraform init
```

Apply terraform changes 
```
terraform apply 
```

It would ask for `projectName` - your VPC and other supporting resources will be named on this so choose a wise one. i.e: alpha-staging

**NOTE**: Do not use a very long projecname because AWS has restriction on the name length for some resources. Upto 10 words should be fine.

and IAM access key and secret key along with region. 

After giving inputs it would take your consent to run the code and apply changes. 
Hit Y or Yes and enter. 

It would go and setup VPC for you following best practices and give you output in green text. 
