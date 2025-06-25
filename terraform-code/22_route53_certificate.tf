# Create Public Hosted Zone
resource "aws_route53_zone" "kn_zone" {
  name = "aws.knsecurecloud.com"
}

# Replace GoDaddy's existing NS records with the Name Server addresses assigned by AWS Route 53

# Create the certificate using a wildcard for all the domains created in aws.knsecurecloud.com
resource "aws_acm_certificate" "kn_cert" {
  domain_name       = "*.aws.knsecurecloud.com"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "kn_zone" {
  name         = "aws.knsecurecloud.com"
  private_zone = false
  depends_on   = [aws_route53_zone.kn_zone]
}


# selecting validation method
resource "aws_route53_record" "kn_record" {
  for_each = {
    for dvo in aws_acm_certificate.kn_cert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.kn_zone.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "kn_validation" {
  certificate_arn         = aws_acm_certificate.kn_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.kn_record : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.kn_zone.zone_id
  name    = "tooling.aws.knsecurecloud.com"
  type    = "A"

  alias {
    name                   = aws_lb.external-alb.dns_name
    zone_id                = aws_lb.external-alb.zone_id
    evaluate_target_health = true
  }
}


# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.kn_zone.zone_id
  name    = "wordpress.aws.knsecurecloud.com"
  type    = "A"

  alias {
    name                   = aws_lb.external-alb.dns_name
    zone_id                = aws_lb.external-alb.zone_id
    evaluate_target_health = true
  }
}