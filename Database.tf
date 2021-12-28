# DB Security Group

resource "aws_security_group" "Prince-database-security" {
  name        = "Prince-database-security"
  description = "Allow http inbound traffic within mysql"
  vpc_id      = aws_vpc.VPC-Project8.id

}

resource "aws_security_group_rule" "database_inbound" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  
  security_group_id = aws_security_group.Prince-database-security.id
}
resource "aws_security_group_rule" "database_outbound" {
  
type              = "egress"

    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

    security_group_id = aws_security_group.Prince-database-security.id
  
  }

 

#The RDS 

resource "aws_db_instance" "prince_rds" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "prince_rds"
  username             = "prince"
  password             = "teacher12"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = "true"
  db_subnet_group_name = aws_db_subnet_group.database-subnet-group.id
  
  multi_az = "true"
}

# RDS SUBNET GROUP

resource "aws_db_subnet_group" "database-subnet-group" {
  name       = "subnet-group"
  
  subnet_ids = [aws_subnet.database-subnet-1.id, aws_subnet.database-subnet-2.id]

  tags = {
    Name = "database-subnet-group"
  }
}


