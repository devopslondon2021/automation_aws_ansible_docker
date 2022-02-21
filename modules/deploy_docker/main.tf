# This module is dependent on EC2 and SSH key
resource "null_resource" "docker_provisioner" {
  provisioner "local-exec" {
    command = <<-EOF
    sleep 180 && \
    mkdir -p ~/.ssh && \
    ssh-keyscan -H ${module.project_A_record.route53_A_record_fqdn} >> ~/.ssh/known_hosts && \
    ansible-playbook  ../../ansible/provision-docker-instance.yml
    EOF

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_SSH_RETRIES       = "5"
    }
  }
#   depends_on = [null_resource.test_user_create, null_resource.deploy_ssl, null_resource.test_bastion_connection_before_ssh]
}


# ansible-playbook add-key.yml 
# -i ansible_hosts 
# --user <remote user name> 
# --key-file <Your_Private_key_file.pem> 
# -e "key=<User's public key file full qualified path>"
