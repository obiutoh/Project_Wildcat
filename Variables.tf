# The Variable File 

# The Region 

variable "region" {
  description = "name of region"
  default = "us-east-1"
}

# The VPC

variable "VPC-project8-cidr" {
  description = "Project8 of vpc cidr block"
  default = "10.0.0.0/16"
}


# The Subnets 

variable "cidr-websubnet-pub5" {
  description = "web public subnet 4"
  default = "10.0.1.0/24"
  
}

variable "cidr-websubnet-pub6" {
  description = "web public subnet 5"
  default = "10.0.2.0/24"
  
}

variable "cidr-subnet-Application-priv7" {
  description = "Application private subnet 6"
  default = "10.0.3.0/24"
  
}

variable "cidr-subnet-Application-priv8" {
  description = "Application private subnet 7"
  default = "10.0.4.0/24"
  
}


variable "cidr-subnet-database-priv9" {
  description = "Database private subnet 8"
  default = "10.0.5.0/24"
  
}



variable "cidr-subnet-database-priv10" {
  description = "Database private subnet9"
  default = "10.0.6.0/24"
  
}


