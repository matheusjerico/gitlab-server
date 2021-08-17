output "ip_address" {
  value = {
    for instance in aws_instance.gitlab :
    instance.id => instance.public_ip
  }
  # value = aws_instance.web[*].public_ip
}

output "public_dns" {
  value = {
    for instance in aws_instance.gitlab :
    instance.id => instance.public_dns
  }
  # value = aws_instance.web[*].public_dns
}

output "tag_name" {
  value = {
    for instance in aws_instance.gitlab :
    instance.id => instance.tags
  }
  # value = aws_instance.web[*].tags
}