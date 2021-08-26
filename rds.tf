## RDS Instance Security group ##
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      prefix_list_ids  = null
      security_groups  = null
      ipv6_cidr_blocks = null
      self             = null    
    }
]
  egress = [
    {
      description      = "egress traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      ipv6_cidr_blocks = null
      self             = null    
}
  ]

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "test-rds",
    })
  )
}
## RDS Instance ##
resource "aws_db_instance" "db" {
  identifier     = "test-rds"
  instance_class = var.database_instance_type
  engine         = var.database_engine_type
  engine_version = var.database_engine_version
  allocated_storage   = var.database_storage_size
  multi_az                = var.database_multi_az
  db_subnet_group_name    = aws_db_subnet_group.db.name
  vpc_security_group_ids  = [aws_security_group.allow_tls.id]
  backup_retention_period = var.database_backup_retention_period
  backup_window           = var.database_backup_window
  maintenance_window      = var.database_maintenance_window
  # Security Access #
  username            = "admin"
  password            = "placeholder"
  publicly_accessible = false
## Life cycle policy to avoid any further update in this template ##
  lifecycle {
      ignore_changes = [
        engine_version,
        password,
        backup_retention_period
      ]
    }
  provisioner "local-exec" {
      command = "ansible-playbook passwd.yml -e   'instance_id=${self.id}' -e 'username=${self.username}'"
    }
tags = merge(
      local.common_tags,
      tomap({
        "Name" = "test-rds",
      })
    )
}
