resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  
  tags = {
    Name = "myvpc"
  }

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "mygw"
  }
}

resource "aws_subnet" "subnet"{
  count = length(var.subnet_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  
  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

resource "aws_route_table" "rtable" {

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "MypublicRT"
  }
}

resource "aws_route_table_association" "a" {
  count = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.rtable.id
}


