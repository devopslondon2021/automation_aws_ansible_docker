# Security group for EC2 to allow SSH and docker port
resource "aws_security_group" "ec2_security_group" {
  name        = "${var.projectName}-sg"
  description = "Allow traffic to EC2 instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_traffic_to_bastion"
  }
}

resource "aws_security_group_rule" "ec2_22" {
  type              = "ingress"
  cidr_blocks       = ["${data.external.myipaddr.result.ip}/32"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_security_group.id
}

resource "aws_security_group_rule" "ec2_5000" {
  type              = "ingress"
  cidr_blocks       = ["${data.external.myipaddr.result.ip}/32"]
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_security_group.id
}

resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_security_group.id
}

resource "aws_instance" "ec2" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_ssh_key.key_name

  tags = {
    Name = "dev-ec2"
  }
}
