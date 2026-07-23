resource "aws_key_pair" "example" {
  key_name   = "time"
  public_key = file("C:\\Users\\mahes\\.ssh\\mahesh.pub")
}

resource "aws_instance" "demo" {
  ami                         = "ami-0c02fb55956c7d316"   # Amazon Linux 2
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.example.key_name
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\mahes\\.ssh\\mykey.pem")
    host        = self.public_ip
    timeout     = "5m"
  }

  # 1. Install Apache
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }

  # 2. Upload file to /tmp (ec2-user has permission)
  provisioner "file" {
    source      = "file10"
    destination = "/tmp/index.html"
  }

  # 3. Move file to /var/www/html with sudo
  provisioner "remote-exec" {
  inline = [
    "touch /home/ec2-user/file200",
    "echo 'hello from veera devops nareshit' >> /home/ec2-user/file200"
  ]
}


  # 4. Local confirmation
  provisioner "local-exec" {
    command = "echo EC2 created successfully && touch file500"
  }
  provisioner "local-exec" {
  command = "touch 500"
}


  tags = {
    Name = "provisioner-full-demo"
  }
}
