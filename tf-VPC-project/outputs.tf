output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = var.enable_nat_gateway ? aws_nat_gateway.nat[0].id : ""
}

output "nat_eip_allocation_id" {
  value = var.enable_nat_gateway ? aws_eip.nat_eip[0].id : ""
}

