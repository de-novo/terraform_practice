resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "subnet group for RDS MariaDB"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-parameters"
  family      = "mariadb10.4"
  description = "mariadb parameters"
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
  parameter {
    name  = "max_connections"
    value = "1000"
  }
  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "mariadb" {
  allocated_storage    = 100
  engine               = "mariadb"
  engine_version       = "10.4.13"
  instance_class       = "db.t2.micro"
  identifier           = "mariadb"
  name                 = "mariadb"
  username             = "root"
  password             = var.RDS_PAWSSWORD
  db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name = aws_db_parameter_group.mariadb-parameters.name

  multi_az = false

  vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  storage_type           = "gp2"

  backup_retention_period = 7
  availability_zone       = aws_subnet.main-private-1.availability_zone
  tags = {
    Name = "mariadb-instance"
  }



}
