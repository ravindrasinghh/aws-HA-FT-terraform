#CREATE VPC IN AWS
resource "aws_vpc" "ravindravpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "ravindravpc"
  }
     }

 #CREATE INTERNET IGW and ATTACHING  TO RAVINDRAVPC
 resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.ravindravpc.id}"

  tags = {
    Name = "main"
  }
}

#CREATION OF VPC PUBLIC SUBNET
resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.ravindravpc.id}"
  cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1e"
    map_public_ip_on_launch = "true"

  tags = {
    Name = "Public-Subnet-1"
  }
    }

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.ravindravpc.id}"
  cidr_block              = "10.0.2.0/24"
    availability_zone       = "us-east-1f"
    map_public_ip_on_launch = "true"

  tags = {
    Name = "Public-Subnet-2"
  }
    }


resource "aws_route_table" "public1" {
    vpc_id = "${aws_vpc.ravindravpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags = {
        Name = "Public-Subnet-1"
    }
}

resource "aws_route_table_association" "public1" {
    subnet_id      = "${aws_subnet.public1.id}"
    route_table_id = "${aws_route_table.public1.id}"
}
resource "aws_route_table_association" "public2" {
    subnet_id      = "${aws_subnet.public2.id}"
    route_table_id = "${aws_route_table.public1.id}"
}

#CREATION OF PRIVATE SUBNET
resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.ravindravpc.id}"
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Private-Subnet-1"
  }
}
resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.ravindravpc.id}"
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Private-Subnet-2"
  }
}

resource "aws_route_table" "private1" {
    vpc_id = "${aws_vpc.ravindravpc.id}"
    
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags = {
        Name = "Private-Subnet-1"
    }
}

resource "aws_route_table_association" "private1" {
    subnet_id      = "${aws_subnet.private1.id}"
    route_table_id = "${aws_route_table.private1.id}"
}
resource "aws_route_table_association" "private2" {
    subnet_id      = "${aws_subnet.private2.id}"
    route_table_id = "${aws_route_table.private1.id}"
}


#CREATION OF NAT GATEWAY AND ATTACHING TO PRIVATE SUBNET
resource "aws_eip" "nat" {
   vpc = true
}
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public1.id}"

  tags = {
    Name = "gw NAT"
  }
}
