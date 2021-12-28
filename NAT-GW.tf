# Elastic IP for NAT Gateway

resource "aws_eip" "EIP-IGW" {
  vpc = true
  depends_on = [aws_internet_gateway.Project8-internet-gateway]
  tags = {
    Name = "EIP-IGW"
  }
  
}


  
# Nat Gate way for vpc/subnet -Web-Subnet-1

resource "aws_nat_gateway" "Project8-Nat-WEB1" {
  allocation_id = aws_eip.EIP-IGW.id
  subnet_id     = aws_subnet.Web-Subnet-1.id

  tags = {
    Name = "Project8-Nat-WEB1"
  }

  
}




# To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC. Added above


