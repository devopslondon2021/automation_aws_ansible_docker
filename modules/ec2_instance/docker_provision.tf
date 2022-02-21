# Connect to Docker host and set it up
resource "null_resource" "docker_provisioner" {
  provisioner "local-exec" {
    command = <<-EOF
      sleep 500 && \
      ansible-playbook ../ansible/install-docker.yml \
      -i ../ansible/hosts --user ubuntu \
      --key-file "${var.projectName}.pem"
    EOF

    # environment = {
    #   ANSIBLE_HOST_KEY_CHECKING = "False"
    #   ANSIBLE_SSH_RETRIES       = "5"
    # }
  }
  depends_on = [ aws_instance.ec2, null_resource.ansible_host_file ]
}
