resource "aws_db_subnet_group" "kn-rds-subnet-group" {
  name = "kn-rds-subnet-group"
  subnet_ids = [aws_subnet.PrivateSubnet-3.id,
  aws_subnet.PrivateSubnet-4.id]

  tags = merge(local.tags,
  { Name = "kn-rds-subnet-group" })
}

# create the RDS instance with the subnets group
resource "aws_db_instance" "kn-RDS" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  db_name                = local.db_name
  username               = local.username
  password               = local.password
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.kn-rds-subnet-group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.datalayer-sg.id]
  multi_az               = "false"
}
