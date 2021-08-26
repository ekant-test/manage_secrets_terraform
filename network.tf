## Define the local variable ##
locals {
 service_name = "Test"
 common_tags = {
 Application_Name = "RDS-Test"
 Application_Owner = "Testing"
 Environment = "Dev"
 Project_Code = "xxxxxx"
 }
}
## VPC ##
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

## Route table ##
resource "aws_route_table" "default" {
  vpc_id = aws_vpc.main.id  
  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "db-routetable",
    })
)
}

## Subnet ##
resource "aws_subnet" "db0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "db0-subnet",
    })
  )
}
## Subnet association ##
resource "aws_route_table_association" "db0" {
  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.db0.id
}
## Subnet ##
resource "aws_subnet" "db1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "db1-subnet",
    })
  )
}
## Subnet association ##
resource "aws_route_table_association" "db1" {
  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.db1.id
}

## RDS Instance Subnet Group ##
resource "aws_db_subnet_group" "db" {
  name        = "test-subnetgroup"
  description = "database subnet group"
  subnet_ids  = [aws_subnet.db0.id, aws_subnet.db1.id]
  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "test-rds-subnetgroup",
    })
  )
}
