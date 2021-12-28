# The VPC 

resource "aws_vpc" "VPC-Project8" {
  cidr_block            = var.VPC-project8-cidr
  instance_tenancy      = "default"
  enable_dns_hostnames =  true

  tags = {
    Name               = "VPC-Project8"
  }
}


# Public Subnet_Project8

resource "aws_subnet" "Web-Subnet-1" {
  vpc_id            = aws_vpc.VPC-Project8.id
  cidr_block        = var.cidr-websubnet-pub5
  map_public_ip_on_launch = "true"

  availability_zone = "us-east-1a"

  tags = {
    Name            = "Web-Subnet-1"
  }
}


# Public Subnet_2

resource "aws_subnet" "Web-Subnet-2" {
  vpc_id            = aws_vpc.VPC-Project8.id
  cidr_block        = var.cidr-websubnet-pub6
  map_public_ip_on_launch = "true"


  availability_zone = "us-east-1b"

  tags = {
    Name            = "Web-Subnet-2"
  }
}


# Project8 Private_application_1

resource "aws_subnet" "application-subnet-1" {
  vpc_id     = aws_vpc.VPC-Project8.id
  cidr_block = var.cidr-subnet-Application-priv7
  map_public_ip_on_launch = "false"

  availability_zone = "us-east-1a"

  tags = {
    Name = "application-subnet-1"
  }
}

# Project8 Private_application_2
resource "aws_subnet" "application-subnet-2" {
  vpc_id     = aws_vpc.VPC-Project8.id
  cidr_block = var.cidr-subnet-Application-priv8
  map_public_ip_on_launch = "false"
  
  availability_zone = "us-east-1b"

  tags = {
    Name = "application-subnet-2"
  }
}

# Project8 Private_Database_1
resource "aws_subnet" "database-subnet-1" {
  vpc_id     = aws_vpc.VPC-Project8.id
  cidr_block = var.cidr-subnet-database-priv9
   map_public_ip_on_launch = "false"

  availability_zone = "us-east-1a"

  tags = {
    Name = "database-subnet-1"
  }
}



# Project8 Private_Database_2
resource "aws_subnet" "database-subnet-2" {
  vpc_id     = aws_vpc.VPC-Project8.id
  cidr_block = var.cidr-subnet-database-priv10
  availability_zone = "us-east-1b"
   map_public_ip_on_launch = "false"

  tags = {
    Name = "database-subnet-2"
  }
}






# Web-Route Table_Public

resource "aws_route_table" "Web-rt-routetable" {
  vpc_id = aws_vpc.VPC-Project8.id



  tags = {
    Name = "Web-rt-routetable"
  }
}


# Database & Application-Route Table Private
resource "aws_route_table" "Data_Application-rt-routetable" {
  vpc_id = aws_vpc.VPC-Project8.id



  tags = {
    Name = "Data_Application-rt-routetable"
  }
}




# Web-Route Table Public Association with Route1

resource "aws_route_table_association" "Public-web-layer1" {
  subnet_id      = aws_subnet.Web-Subnet-1.id
  route_table_id = aws_route_table.Web-rt-routetable.id
}


# Web-Route Table Public Association with Route2

resource "aws_route_table_association" "Public-web-layer2" {
  subnet_id      = aws_subnet.Web-Subnet-2.id
  route_table_id = aws_route_table.Web-rt-routetable.id
}



# The Private_subnet_Database Association with Route1

resource "aws_route_table_association" "Database-RT1" {
  subnet_id      = aws_subnet.database-subnet-1.id
  route_table_id = aws_route_table.Data_Application-rt-routetable.id
}

# The Private_subnet-Database Association with Route2

resource "aws_route_table_association" "Private-Subnetaso2" {
  subnet_id      = aws_subnet.database-subnet-2.id
  route_table_id = aws_route_table.Data_Application-rt-routetable.id
}

# The Private_subnet-Application Association with RouteA

resource "aws_route_table_association" "Application-Subnet-Ass1" {
  subnet_id      = aws_subnet.application-subnet-1.id
  route_table_id = aws_route_table.Data_Application-rt-routetable.id
}


# The Private_subnet-Application Association with RouteB

resource "aws_route_table_association" "Application-Subnet-Ass2" {
  subnet_id      = aws_subnet.application-subnet-2.id
  route_table_id = aws_route_table.Data_Application-rt-routetable.id
}



# The_Internet Gateway 


resource "aws_internet_gateway" "Project8-internet-gateway" {
  vpc_id       = aws_vpc.VPC-Project8.id

  tags = {
    Name       = "Project8-internet-gateway"
  }
}


# Connect of Routable and Internet Gate Way

# Conection of Route to Internet GW And Pub-Route


resource "aws_route" "Public-route-igwroute" {
  route_table_id            = aws_route_table.Web-rt-routetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Project8-internet-gateway.id   
              
} 

resource "aws_route" "Private-route-application1" {
  route_table_id            = aws_route_table.Data_Application-rt-routetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_nat_gateway.Project8-Nat-WEB1.id   
              
} 


# security_groups

resource "aws_security_group" "web_sg" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = aws_vpc.VPC-Project8.id



  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  tags = {
    Name = "allow_ssh_http"
  }
}


