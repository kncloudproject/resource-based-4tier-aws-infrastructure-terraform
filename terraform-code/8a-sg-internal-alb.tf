# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "int-alb-sg" {
  name        = "kn-int-alb-sg"
  vpc_id      = aws_vpc.main.id
  description = "Internal SG ALB"


  tags = {
    Name = "kn-int-alb-sg"
  }

}