# Web EC2 -1
resource "aws_instance" "webserver1_project8" {

  ami             = "ami-0ed9277fb7eb570c9" 
  instance_type   = "t2.micro"
  key_name        = "Project8_Tri"
  subnet_id       = aws_subnet.Web-Subnet-1.id
 
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.web_sg.id]


  user_data = <<EOF
  #!/bin/bash

# get admin privileges
sudo su

# install httpd (Linux 2 version)
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  
  EOF

  tags = {
  
    
    Name = "webserver1_project8"
  } 
}

# Web EC2 -2

resource "aws_instance" "webserver2_project8" {

  ami             = "ami-061ac2e015473fbe2" 
  instance_type   = "t2.micro"
  key_name        = "Project8_EC2"
  subnet_id       = aws_subnet.Web-Subnet-2.id
 
  availability_zone = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.web_sg.id]


  user_data = <<EOF

   #!/bin/bash

# get admin privileges
sudo su

# install httpd (Linux 2 version)
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  
  EOF

  tags = {
  
    
    Name = "webserver2_project8"
  } 
}