# security group for alb, to allow acess from any where for HTTP and HTTPS traffic

resource "aws_security_group" "datalayer-sg" {
  name        = "kn-datalayer-sg"
  vpc_id      = aws_vpc.main.id
  description = "Datalayer SG"


  tags = {
    Name = "kn-datalayer-sg"
  }

}