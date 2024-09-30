
resource "aws_vpc" "vpc_mod" {
    cidr_block = var.vpc_cidr
    
tags = {
  Name = "VPC-Shekhar"
}

}

resource "aws_internet_gateway" "public_internet_gatway" {
    vpc_id = aws_vpc.vpc_mod.id

    tags = {
        Name = "IGW-shekhar"
    }
}

#public subnet
resource "aws_subnet" "aws_public_subnet" {
    count = length(var.cidr_public_subnet)
    vpc_id = aws_vpc.vpc_mod.id
    cidr_block = element(var.cidr_public_subnet,count.index)
    availability_zone = element(var.us_availability_zone,count.index)

    tags = {
      Name = "Public subnet sh"
    }

  
}

#private subnet 

resource "aws_subnet" "aws_private_subnet" {
    count = length(var.cidr_private_subnet)
    vpc_id = aws_vpc.vpc_mod.id
    cidr_block = element(var.cidr_private_subnet,count.index)
    availability_zone = element(var.us_availability_zone,count.index)
    
    tags = {
      Name = "private sub"
    }
  
}


resource "aws_eip" "nat_eip" {
    count = length(var.cidr_private_subnet)
    
  
}

resource "aws_nat_gateway" "nat_gatway" {
    count = length(var.cidr_private_subnet)
    depends_on = [ aws_eip.nat_eip ]
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id = aws_subnet.aws_private_subnet[count.index].id

    tags = {
      Name = "Priavte nat"
    }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_mod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_internet_gatway.id
  }
  tags = {
    Name = "RT Pub"
  }
}

#private route table
resource "aws_route_table" "private_route_table" {
  count      = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.vpc_mod.id
  depends_on = [aws_nat_gateway.nat_gatway]
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gatway[count.index].id
  }
  tags = {
    Name = "RT Pri"
  }
}

resource "aws_route_table_association" "aws_public_assoc" {
  count = length(var.cidr_public_subnet)
  subnet_id = element(aws_subnet.aws_public_subnet[*].id,count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "aws_private_assoc" {
  count = length(var.cidr_private_subnet)
  subnet_id = element(aws_subnet.aws_private_subnet[*].id,count.index)
  route_table_id = aws_route_table.private_route_table[count.index].id
  
}



output "public_subnet_id" {
  value = aws_subnet.aws_public_subnet[*].id
}

output "priavte_subnet_id" {
  value = aws_subnet.aws_private_subnet[*].id
}

