output "vpc_id" { value = aws_vpc.main_vpc.id }
output "public_subnet_a_id" { value = aws_subnet.public_subnet_a.id }
output "public_subnet_b_id" { value = aws_subnet.public_subnet_b.id }
output "private_subnet_a_id" { value = aws_subnet.private_subnet_a.id }
output "private_subnet_b_id" { value = aws_subnet.private_subnet_b.id }
output "nat_gateway_id" { value = aws_nat_gateway.nat_gw.id }
output "internet_gateway_id" { value = aws_internet_gateway.igw.id }