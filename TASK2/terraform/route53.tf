resource "aws_route53_zone" "domain-name" {
  name = local.domain-name
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "cert-validation" {
  name = module.acm.resource_record_name
  type = module.acm.resource_record_type
  zone_id = aws_route53_zone.domain-name.zone_id
  records = [module.acm.resource_record_value]
  ttl = 10
}

resource "aws_route53_record" "public_alb" {
  name = local.domain-name
  type = "A"
  zone_id = aws_route53_zone.domain-name.zone_id
  alias {
    evaluate_target_health = false
    name = module.web-application-public-alb.dns_name
    zone_id = module.web-application-public-alb.zone_id
  }
  depends_on = [module.web-application-public-alb]
}

resource "aws_route53_record" "rdsdns" {
  name = "redis.${local.domain}"
  type = "CNAME"
  zone_id = aws_route53_zone.privatezone.zone_id
  ttl     = "10"
  records = [module.redis.endpoint]
  depends_on = [module.redis]
}
