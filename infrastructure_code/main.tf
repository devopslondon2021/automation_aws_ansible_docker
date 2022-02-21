module "vpc" {
  source        = "../modules/vpc"
  projectName   = var.projectName 
}

module "ec2" {
    source           = "../modules/ec2_instance"
    projectName      = var.projectName
    vpc_id           = module.vpc.vpc_id
    public_subnet_id = element(module.vpc.public_subnet_id, 0)
}
