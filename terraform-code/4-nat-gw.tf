resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.ig]


  tags = {
    Name = "kn-main-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.PublicSubnet-1.id
  depends_on    = [aws_internet_gateway.ig, aws_eip.nat_eip]


  tags = {
    Name = "kn-main-natgw"
  }
}