# resource "aws_internet_gateway_attachment" "igw_attachment" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.main.id

#   depends_on = [aws_internet_gateway.igw, aws_vpc.main]
# }

resource "aws_route" "internet_connection" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_route_table.public_rtb]
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id

  depends_on = [aws_subnet.public_subnet]
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rtb.id

  depends_on = [aws_subnet.private_subnet]
}

resource "aws_security_group_rule" "main_ingress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.main_sg.id

  depends_on = [aws_vpc.main, aws_security_group.main_sg]
}