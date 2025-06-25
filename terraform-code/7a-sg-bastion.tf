# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "bastion-sg" {
  name        = "kn-bastion-sg"
  vpc_id      = aws_vpc.main.id
  description = "Bastion SG"


  tags = {
    Name = "kn-bastion-sg"
  }

}