# Generate SSH key to for EC2
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "my_ssh_key" {
  key_name   = "${var.projectName}-ssh-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Save SSH file locally so that user can access it
resource "local_file" "ssh_key_file" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "${var.projectName}.pem"

  provisioner "local-exec" {
    command = "chmod 600 ${var.projectName}.pem"
  }
  provisioner "local-exec" {
    command = "cat ${var.projectName}.pem | ssh-add -k -"
  }
}
