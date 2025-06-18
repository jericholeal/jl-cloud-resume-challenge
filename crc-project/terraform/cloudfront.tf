# Origin Access Control (S3 + CloudFront)
resource "aws_cloudfront_origin_access_control" "oac" {
  name = "jericho-crc-site-oac"
  description = "OAC for secure S3 access"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

# CloudFront distribution for S3 static website
resource "aws_cloudfront_distribution" "jericho-crc-site-cf-distribution" {
  origin {
    domain_name = aws_s3_bucket.jericho-crc-site.bucket_regional_domain_name
    origin_id = "s3-jericho-crc-site-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "auth.html"
  price_class = "PriceClass_100" # for cost optimization
  comment = "CDN for jericho-crc-site static website hosting"
  
  # Domain name
  aliases = ["jericho-crc-site.xyz", "www.jericho-crc-site.xyz"]

  # TLS certificate from ACM in us-east-1  
  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_cache_behavior {
    allowed_methods = [ "GET", "HEAD" ]      
    cached_methods = [ "GET", "HEAD" ]
    target_origin_id = "s3-jericho-crc-site-origin"
    compress = true # for performance optimization

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      }
  }

  logging_config {
    bucket = aws_s3_bucket.jericho-crc-site-cloudfront-logs.bucket_domain_name
    include_cookies = false
    prefix = "cloudfront-logs/"
  }

  tags = {
    Project = "jericho-crc-site"
  }
}