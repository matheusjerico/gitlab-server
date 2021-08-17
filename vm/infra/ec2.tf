data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_key_pair" "matheus_aws" {
  key_name   = "id_rsa_matheus_aws"
  public_key = file("${var.key_path}.pub")
}


resource "aws_security_group" "ssh_http" {
  name        = "ssh_http"
  description = "Allow SSH and HTTP"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.my_ipv4_address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "gitlab" {
  ami = data.aws_ami.ubuntu.id

  count         = var.instance_count
  instance_type = var.instance_type
  key_name      = aws_key_pair.matheus_aws.key_name

  security_groups = [aws_security_group.ssh_http.name]

  tags = {
    Name = "gitlab-0${count.index}"
    Type = "gitlab"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.user_ec2
      host        = self.public_ip
      timeout     = "2m"
      private_key = file(var.key_path)
    }

    inline = [
      "sudo hostname gitlab-server-${count.index}",
      "echo gitlab-server-0${count.index} | sudo tee /etc/hostname"
    ]
  }

}
