# Request a public certificate for the domain from ACM in us-east-1
resource "aws_acm_certificate" "jericho_crc_site_cert" {
  domain_name = "jericho-crc-site.xyz"
  validation_method = "DNS"

  tags = {
    Project     = "jericho-crc-site"
  }

  provider = aws.us_east_1
}

# Create DNS validation record for ACM certificate in Route 53
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.jericho_crc_site_cert.domain_validation_options : dvo.domain_name => {
			name = dvo.resource_record_name
			type = dvo.resource_record_type
			value = dvo.resource_record_value
    }
  }

	name = each.value.name
	type = each.value.type
	zone_id = var.hosted_zone_id
	ttl = 300
	records = [each.value.value]
}

# Validate the ACM certificate using DNS validation once the record is created
resource "aws_acm_certificate_validation" "cert_validation" {
	certificate_arn = aws_acm_certificate.jericho_crc_site_cert.arn
	validation_record_fqdns = [ for record in aws_route53_record.cert_validation : record.fqdn ]	
}



