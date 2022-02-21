resource "aws_vpc" "vpc" {
    cidr_block = var.cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "${var.projectName}-vpc"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.projectName}-igw"
    }
}

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id 
    }

    tags = {
        Name = "${var.projectName}-public-route"
    }
}

resource "aws_subnet" "public_subnet" {
    count = 2
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.public_cidr[count.index]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.availability.names[count.index]

    tags = {
        Name = "${var.projectName}-public-subnet-${count.index + 1}"
    }
}

resource "aws_route_table_association" "public_association" {
    count = length(aws_subnet.public_subnet)
    subnet_id = aws_subnet.public_subnet.*.id[count.index]
    route_table_id = aws_route_table.public_route.id
}

resource "aws_subnet" "private_subnet" {
    count = 2
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_cidr[count.index]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.availability.names[count.index]

    tags = {
        Name = "${var.projectName}-private-subnet-${count.index + 1}"
    }
}

resource "aws_eip" "nateip" {
    vpc = true

    tags = {
        Name = "${var.projectName}-eip"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nateip.id
    subnet_id = aws_subnet.public_subnet[0].id
    depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.vpc.id 

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }

    tags = {
        Name = "${var.projectName}-private-route"
    }
}

resource "aws_route_table_association" "private_association" {
    count = length(aws_subnet.private_subnet)
    subnet_id = aws_subnet.private_subnet.*.id[count.index]
    route_table_id = aws_route_table.private_route.id
}
