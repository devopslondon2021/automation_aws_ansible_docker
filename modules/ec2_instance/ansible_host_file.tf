resource "null_resource" "ansible_host_file" {
  provisioner "local-exec" {
    command = <<-EOF
        echo "[ec2]" > ../ansible/hosts && echo "${aws_instance.ec2.public_ip}" >> ../ansible/hosts      
     EOF
  }
  depends_on = [ aws_instance.ec2 ]
}
