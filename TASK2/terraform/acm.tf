module "acm" {
  source = "../tf-module/acm"
  domain_name = aws_route53_zone.domain-name.name
  subject_alternative_names = ["*.${aws_route53_zone.domain-name.name}"]
  tags = merge(map("Name",join("-",[local.env,local.project,"acm"])),map("ResourceType","acm"),local.common_tags)
  validation_record_fqdns = aws_route53_record.cert-validation.fqdn
}