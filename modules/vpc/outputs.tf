output "vpc_id" {
    description = "id of the vpc created"
    value = aws_vpc.this.id
}

output "internet_gateway_id" {
    description = "id of the internet gateway created"
    value = aws_internet_gateway.this.id

}

output "public_subnet_ids" {
    description = "id of the public subnet created"
    value ={
        for key,subnet in aws_subnet.public:
        key => subnet.id
    } 

}

output "private_app_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.private_app :
    key => subnet.id
  }
}

output "private_db_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.private_db :
    key => subnet.id
  }
}


output "nat_gateway_id" {
  description = "id of the nat gateway created "
  value = aws_nat_gateway.this.id
}

output "nat_eip" {
  description = "public ip of the eip created "
  value = aws_eip.this.public_ip
}

output "public_route_table_id" {
  description = "public route table id "
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "private route table id" 
  value = aws_route_table.private_app.id
}

output "database_route_table_id" {
  description = "database route table id" 
  value = aws_route_table.private_db.id
}



