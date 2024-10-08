# 2. Create Internet Gateway 
resource "aws_internet_gateway" "ejb-gw" {
  vpc_id = aws_vpc.ejb-prod-vpc.id
}

# 3. Create Route Table
resource "aws_route_table" "ejb-prod-route-table" {
  vpc_id = aws_vpc.ejb-prod-vpc.id
  route {
    # All traffic to the internet gateway
    cidr_block = local.route_cidr_block
    gateway_id = aws_internet_gateway.ejb-gw.id
  }

  route {
    ipv6_cidr_block = local.ejb_ipv6_cidr_block
    gateway_id      = aws_internet_gateway.ejb-gw.id
  }
  tags = {
    Name = "ejb-prod-route-table"
  }
}

# 4. Create a subnet-1
resource "aws_subnet" "ejb-subnet-1" {
  vpc_id                  = aws_vpc.ejb-prod-vpc.id
  cidr_block              = local.ejb_sub1_cidr_block
  availability_zone       = local.ejb_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "Prod-subnet-1"
  }
}

# 5. Associate subnet with route table 
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.ejb-subnet-1.id
  route_table_id = aws_route_table.ejb-prod-route-table.id
}

# 6. Create Security group 22, 80, 443
resource "aws_security_group" "ejb-allow_web" {
  name        = "allow_web traffic"
  description = "Allow web inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.ejb-prod-vpc.id

  dynamic "ingress" {
    for_each = local.security_group_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ejb-allow-tls"
  }
}

# 7. Create network interface 
resource "aws_network_interface" "ejb-web-server-nic" {
  subnet_id       = aws_subnet.ejb-subnet-1.id
  private_ips     = [local.web_server_private_ip]
  security_groups = [aws_security_group.ejb-allow_web.id]
}

# 8. Assign Public EIP
resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.ejb-web-server-nic.id
  associate_with_private_ip = local.web_server_private_ip
  depends_on                = [aws_internet_gateway.ejb-gw]
}
