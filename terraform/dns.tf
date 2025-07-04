# # Create DNS zone
# resource "aws_route53_zone" "devops" {
#   name = "devops.ntslab.eu"
# }

# Create bastion DNS record
resource "aws_route53_record" "bastion" {
  zone_id = var.NW["dns_zone_id"]
  name    = var.NW["bastion_dns_fqdn"]
  type    = "A"
  ttl     = 28800
  records = [aws_eip.bastion.public_ip]

  depends_on = [aws_eip.bastion]
}

# Create guacamole DNS records (CNAME) pointing to the ALB
resource "aws_route53_record" "guacamole" {
  zone_id = var.NW["dns_zone_id"]
  name    = var.NW["guacamole_dns_fqdn"]
  type    = "CNAME"
  ttl     = 28800
  records = [aws_lb.devops-infra.dns_name]
}

# Create all other DNS records (CNAME) pointing to the ALB
resource "aws_route53_record" "lab" {
  for_each = tomap({
    for name in local.lab_instance_names : name => name
  })
  #zone_id = aws_route53_zone.devops.zone_id
  zone_id = var.NW["dns_zone_id"]
  name    = each.key
  type    = "CNAME"
  ttl     = 28800
  records = [aws_lb.devops-infra.dns_name]
}

# Create certificate validation DNS record
resource "aws_route53_record" "lab_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.lab.domain_validation_options : dvo.domain_name => {
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
  zone_id         = var.NW["dns_zone_id"]

  #depends_on = [aws_route53_record.lab]
}

# Create a certificate with SAN entries for the DNS names
resource "aws_acm_certificate" "lab" {
  domain_name               = var.NW["guacamole_dns_fqdn"]
  #subject_alternative_names = local.cert_dns_names
  subject_alternative_names = [var.NW["guacamole_dns_fqdn"], "*.aws.ntslab.eu"]
  validation_method         = "DNS"

  #depends_on = [aws_route53_record.lab_validation_record]

  lifecycle {
    create_before_destroy = true
  }
}

# Create a certificate validation
resource "aws_acm_certificate_validation" "lab_validation" {
  certificate_arn         = aws_acm_certificate.lab.arn
  validation_record_fqdns = [for record in aws_route53_record.lab_validation_record : record.fqdn]

  depends_on = [aws_route53_record.lab_validation_record]
}
