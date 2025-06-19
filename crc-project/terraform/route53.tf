# Hosted zone
data "aws_route53_zone" "jericho_crc_site_zone" {
    zone_id = var.hosted_zone_id
    private_zone = false
}

# Alias record pointing to CloudFront distribution
resource "aws_route53_record" "jericho_crc_site_cdn_alias" {
    zone_id = data.aws_route53_zone.jericho_crc_site_zone.zone_id
    name = "jericho-crc-site.xyz"
    type = "A"

    alias {
        name = aws_cloudfront_distribution.jericho_crc_site_cdn_alias.domain_name
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}

# www subdomain alias record redirecting to root domain
resource "aws_route53_record" "www_alias" {
    zone_id = data.aws_route53_zone.jericho_crc_site_zone.zone_id
    name = "www.jericho-crc-site.xyz"
    type = "CNAME"
    ttl = 300
    records = ["jericho-crc-site.xyz"]
}
