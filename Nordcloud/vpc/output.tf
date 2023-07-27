output "vpc_id" {
	value = aws_vpc.nordcloudtest_vpc.id
}

output "Pub_sub01_id" {
	value = aws_subnet.nordcloudtest_Pub_sub01.id
}

output "Pub_sub02_id" {
	value = aws_subnet.nordcloudtest_Pub_sub02.id
}

output "App_sub01_id" {
	value = aws_subnet.nordcloudtest_App_sub01.id
}

output "App_sub02_id" {
	value = aws_subnet.nordcloudtest_App_sub02.id
}

output "DB_sub01_id" {
	value = aws_subnet.nordcloudtest_DB_sub01.id
}

output "DB_sub02_id" {
	value = aws_subnet.nordcloudtest_DB_sub02.id
}