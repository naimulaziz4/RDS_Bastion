output "main_vpc_id" {
  value = aws_vpc.main.id

  depends_on = [aws_vpc.main]
}

output "security_group_id" {
  value = aws_security_group.main_sg.id

  depends_on = [aws_security_group.main_sg]
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id

  depends_on = [aws_subnet.public_subnet]
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id

  depends_on = [aws_subnet.private_subnet]
}