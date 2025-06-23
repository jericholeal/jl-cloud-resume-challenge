# jericho_crc_site S3 bucket configuration
resource "aws_s3_bucket" "jericho_crc_site" {
  bucket = "jericho_crc_site"
}
resource "aws_s3_bucket_server_side_encryption_configuration" "jericho_crc_site-encryption" {
	bucket = aws_s3_bucket.jericho_crc_site.id
	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
	}
}

resource "aws_s3_bucket_acl" "jericho_crc_site_acl" {
  bucket = aws_s3_bucket.jericho_crc_site.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "jericho_crc_site-versioning" {
	bucket = aws_s3_bucket.jericho_crc_site.id
	versioning_configuration {
		status = "Enabled"
	}
}

# jericho_crc_site_logs S3 bucket configuration
resource "aws_s3_bucket" "jericho_crc_site_logs" {
  bucket = "jericho_crc_site_logs"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Project = "jericho_crc_site"
    Purpose = "CloudFront logging"
  }
}
resource "aws_s3_bucket_acl" "jericho_crc_site_logs-acl" {
  bucket = aws_s3_bucket.jericho_crc_site_logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_versioning" "jericho_crc_site_logs-versioning" {
	bucket = aws_s3_bucket.jericho_crc_site_logs.id
	versioning_configuration {
		status = "Enabled"
	}
}

resource "aws_s3_bucket_policy" "jericho_crc_site-cloudfront-logging-policy" {
  bucket = aws_s3_bucket.jericho_crc_site_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "delivery.logs.amazonaws.com"
      },
      Action = "s3:PutObject",
      Resource = "arn:aws:s3:::jericho_crc_site_logs/*",
      Condition = {
        StringEquals =  {
          "AWS:SourceAccount" = local.account_id
        }			
      }
  	}]
  })
}