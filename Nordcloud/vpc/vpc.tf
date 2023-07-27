# VPC Creation
resource "aws_vpc" "nordcloudtest_vpc" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "nordcloudtest_vpc"
  }
}

# Pub_Sub01 Creation
resource "aws_subnet" "nordcloudtest_Pub_sub01" {
	cidr_block = var.Pub_Sub_01_cidr
	vpc_id = aws_vpc.nordcloudtest_vpc.id

	tags = {
    Name = "nordcloudtest_Pub_Subnet_01"
  }

}

# Pub_Sub02 Creation
resource "aws_subnet" "nordcloudtest_Pub_sub02" {
	cidr_block = var.Pub_Sub_02_cidr
	vpc_id = aws_vpc.nordcloudtest_vpc.id

	tags = {
    Name = "nordcloudtest_Pub_Subnet_02"
  }

}


# App_Sub01 Creation
resource "aws_subnet" "nordcloudtest_App_sub01" {
	cidr_block = var.App_Sub_01_cidr
	vpc_id = aws_vpc.nordcloudtest_vpc.id

	tags = {
    Name = "nordcloudtest_App_Subnet_01"
  }

}

# App_Sub02 Creation
resource "aws_subnet" "nordcloudtest_App_sub02" {
	cidr_block = var.App_Sub_02_cidr
	vpc_id = aws_vpc.nordcloudtest_vpc.id

	tags = {
    Name = "nordcloudtest_App_Subnet_02"
  }

}


# DB_Sub01 Creation
resource "aws_subnet" "nordcloudtest_DB_sub01" {
	cidr_block = var.DB_Sub_01_cidr
	vpc_id = aws_vpc.nordcloudtest_vpc.id

	tags = {
    Name = "nordcloudtest_DB_Subnet_01"
  }

}

# DB_Sub02 Creation
resource "aws_subnet" "nordcloudtest_DB_sub02" {
	cidr_block = var.DB_Sub_02_cidr
	vpc_id = aws_vpc.nordcloudtest_vpc.id

	tags = {
    Name = "nordcloudtest_DB_Subnet_02"
  }

}

# IGW Creation
resource "aws_internet_gateway" "nordcloudtest_igw" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  tags = {
    Name = "NORDCLOUDTEST-IGW"
  }
}

# EIP 
resource "aws_eip" "nordcloudtest_eip" {

}

# NAT Gatway Creation
resource "aws_nat_gateway" "nordcloudtest_NAT" {
  allocation_id = aws_eip.nordcloudtest_eip.id
  subnet_id     = aws_subnet.nordcloudtest_sub01.id

  tags = {
    Name = "NORDCLOUDTEST-NAT-GW"
  }

  depends_on = [aws_internet_gateway.nordcloudtest_igw]
}


# Route Pub-table-01 creation
resource "aws_route_table" "nordcloudtest_Pub_rt_1" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  route {
    cidr_block = "10.1.0.0/23"
    gateway_id = aws_internet_gateway.nordcloudtest_igw.id
  }

  
  tags = {
    Name = "nordcloudtest_Pub_rt_1"
  }
}


# Route Pub-table-02 creation
resource "aws_route_table" "nordcloudtest_Pub_rt_2" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  route {
    cidr_block = "10.1.2.0/23"
    gateway_id = aws_internet_gateway.nordcloudtest_igw.id
  }

  
  tags = {
    Name = "nordcloudtest_Pub_rt_2"
  }
}

# Route App-table-01 creation
resource "aws_route_table" "nordcloudtest_App_rt_1" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  route {
     cidr_block = "10.1.4.0/23"
     gateway_id = aws_nat_gateway.nordcloudtest_NAT.id
  }

  depends_on = [aws_nat_gateway.nordcloudtest_NAT]
  
  tags = {
    Name = "nordcloudtest_App_rt_1"
  }
}

# Route App-table-02 creation
resource "aws_route_table" "nordcloudtest_App_rt_2" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  route {
     cidr_block = "10.1.6.0/23"
     gateway_id = aws_nat_gateway.nordcloudtest_NAT.id
  }

  depends_on = [aws_nat_gateway.nordcloudtest_NAT]
  
  tags = {
    Name = "nordcloudtest_App_rt_2"
  }
}

# Route DB-table-01 creation
resource "aws_route_table" "nordcloudtest_DB_rt_1" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  route {
     cidr_block = "10.1.8.0/23"
     gateway_id = aws_nat_gateway.nordcloudtest_NAT.id
  }

  depends_on = [aws_nat_gateway.nordcloudtest_NAT]
  
  tags = {
    Name = "nordcloudtest_DB_rt_1"
  }
}

# Route DB-table-02 creation
resource "aws_route_table" "nordcloudtest_DB_rt_2" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  route {
     cidr_block = "10.1.10.0/23"
     gateway_id = aws_nat_gateway.nordcloudtest_NAT.id
  }

  depends_on = [aws_nat_gateway.nordcloudtest_NAT]
  
  tags = {
    Name = "nordcloudtest_DB_rt_2"
  }
}

# Pub_Sub01 RT association
resource "aws_route_table_association" "Pub_sub01_association" {
  subnet_id      = aws_subnet.nordcloudtest_Pub_sub01.id
  route_table_id = aws_route_table.nordcloudtest_Pub_rt_1.id
}

# Pub_Sub02 RT association
resource "aws_route_table_association" "Pub_sub02_association" {
  subnet_id      = aws_subnet.nordcloudtest_Pub_sub02.id
  route_table_id = aws_route_table.nordcloudtest_Pub_rt_2.id
}

# App_Sub01 RT association
resource "aws_route_table_association" "App_sub01_association" {
  subnet_id      = aws_subnet.nordcloudtest_App_sub01.id
  route_table_id = aws_route_table.test_App_rt_1.id
}

# App_Sub02 RT association
resource "aws_route_table_association" "App_sub02_association" {
  subnet_id      = aws_subnet.nordcloudtest_App_sub02.id
  route_table_id = aws_route_table.test_App_rt_2.id
}

# DB_Sub01 RT association
resource "aws_route_table_association" "DB_sub01_association" {
  subnet_id      = aws_subnet.test_DB_sub01.id
  route_table_id = aws_route_table.test_DB_rt_1.id
}

# DB_Sub02 RT association
resource "aws_route_table_association" "DB_sub02_association" {
  subnet_id      = aws_subnet.test_DB_sub02.id
  route_table_id = aws_route_table.test_DB_rt_2.id
}

# Create PUB_NACL Creation

resource "aws_network_acl" "PUB_NACL" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  # Tags for the PUB_NACL
  tags = {
    Name = "PUB_NACL"
  }
}

# Inbound rules for the PUB_NACL
resource "aws_network_acl_rule" "Pub_inbound_rule" {
  network_acl_id = aws_network_acl.PUB_NACL.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Outbound rules for the PUB_NACL
resource "aws_network_acl_rule" "Pub_outbound_rule" {
  network_acl_id = aws_network_acl.PUB_NACL.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}


# Create APP-NACL Creation

resource "aws_network_acl" "APP_NACL" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  # Tags for the NACL
  tags = {
    Name = "APP_NACL"
  }
}


# Inbound rules for the APP_NACL
resource "aws_network_acl_rule" "App_inbound_rule" {
  network_acl_id = aws_network_acl.APP_NACL.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  source_network_acl_id = "aws_network_acl.PUB_NACL.id"
  from_port      = 0
  to_port        = 65535
}

# Outbound rules for the APP_NACL
resource "aws_network_acl_rule" "App_outbound_rule" {
  network_acl_id = aws_network_acl.APP_NACL.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

# Create DB-NACL Creation

resource "aws_network_acl" "DB_NACL" {
  vpc_id = aws_vpc.nordcloudtest_vpc.id

  # Tags for the NACL
  tags = {
    Name = "DB_NACL"
  }
}


# Inbound rules for the DB_NACL
resource "aws_network_acl_rule" "DB_inbound_rule" {
  network_acl_id = aws_network_acl.DB_NACL.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  source_network_acl_id = "aws_network_acl.APP_NACL.id"
  from_port      = 0
  to_port        = 65535
}

# Outbound rules for the DB_NACL
resource "aws_network_acl_rule" "DB_outbound_rule" {
  network_acl_id = aws_network_acl.DB_NACL.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}


# PUB_NACL_Association with Sub01
resource "aws_network_acl_association" "Pub_subnet_association_1" {
  subnet_id      = aws_subnet.nordcloudtest_Pub_sub01.id
  network_acl_id = aws_network_acl.PUB_NACL.id
}

# PUB_NACL_Association with Sub02
resource "aws_network_acl_association" "Pub_subnet_association_2" {
  subnet_id      = aws_subnet.nordcloudtest_Pub_sub02.id
  network_acl_id = aws_network_acl.PUB_NACL.id
}

# APP_NACL_Association with Sub01
resource "aws_network_acl_association" "App_subnet_association_1" {
  subnet_id      = aws_subnet.nordcloudtest_App_sub01.id
  network_acl_id = aws_network_acl.APP_NACL.id
}

# APP_NACL_Association with Sub02
resource "aws_network_acl_association" "App_subnet_association_2" {
  subnet_id      = aws_subnet.nordcloudtest_App_sub02.id
  network_acl_id = aws_network_acl.APP_NACL.id
}

# DB_NACL_Association with Sub01
resource "aws_network_acl_association" "DB_subnet_association_1" {
  subnet_id      = aws_subnet.nordcloudtest_DB_sub01.id
  network_acl_id = aws_network_acl.DB_NACL.id
}

# DB_NACL_Association with Sub02
resource "aws_network_acl_association" "DB_subnet_association_2" {
  subnet_id      = aws_subnet.nordcloudtest_DB_sub02.id
  network_acl_id = aws_network_acl.DB_NACL.id
}

# Create VPC Flow Log 
resource "aws_flow_log" "nordcloudtest_flow_log" {
  name           = "nordcloudtest-flow-log"
  vpc_id         = aws_vpc.nordcloudtest_vpc.id
  traffic_type   = "ALL"
  log_destination = "arn:aws:logs:var.region:var.account-id:log-group:var.s3-bucket:*"
}


# Create S3 Backend for managing state file

backend "s3" {
    bucket = var.s3-bucket-nordcloudtest
    key    = "terraform.tfstate" 
    region = var.region      
    encrypt = true               
}