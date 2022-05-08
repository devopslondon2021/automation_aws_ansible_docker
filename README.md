# Automation challenge 

Automation for infrastruture deployment, containerize app, and deploying. 

# Directory structure 
- `.github/workflows/build_docker_and_deploy.yaml` - Github actions file that is responsible to build the docker image and push to ECR
- `ansible/` - Ansible scripts to provision docker on EC2
- `docker-app/` - Flask based python app 
- `infrastructure_code` - Terraform infrastruture code 
- `modules` - Terraform AWS modules 
- `second-challenge` - Python scripts for second challenge
