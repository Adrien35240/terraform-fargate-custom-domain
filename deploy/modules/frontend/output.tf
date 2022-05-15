output "http-front-url" {
  value = "http://${aws_lb.test.dns_name}"
}

output "http-domain-url" {
  value = "http://${aws_route53_record.test-www.fqdn}"
}

output "ecs_repository-uri" {
  value = "${aws_ecr_repository.test.repository_url}"
}