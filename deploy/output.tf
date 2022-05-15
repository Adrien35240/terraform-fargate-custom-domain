output "http-front-url" {
  value = "http://${aws_lb.test.dns_name}"
}

output "http-domain-url" {
  value = "http://${aws_route53_record.test-www.fqdn}"
}