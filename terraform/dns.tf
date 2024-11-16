# Create DNS entry for bastion host
resource "aws_route53_record" "guacamole" {
  zone_id = [var.NW["dns_zone_id"]]
  name    = [var.NW["dns_fqdn"]]
  type    = "CNAME"
  ttl     = 28800
  records = [aws_lb.bastion.dns_name]
}

resource "aws_route53_record" "guacamole_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.guacamole.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = [var.NW["dns_zone_id"]]
}

resource "aws_acm_certificate" "guacamole" {
  domain_name               = [var.NW["dns_fqdn"]]
  subject_alternative_names = [var.NW["dns_fqdn"]]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "guacamole_validation" {
  certificate_arn         = aws_acm_certificate.guacamole.arn
  validation_record_fqdns = [for record in aws_route53_record.guacamole_validation_record : record.fqdn]
}


