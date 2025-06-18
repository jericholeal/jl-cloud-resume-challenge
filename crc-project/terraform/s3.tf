
# jericho-crc-site S3 bucket configuration
resource "aws_s3_bucket" "jericho-crc-site" {
  bucket = "jericho-crc-site"
}
resource "aws_s3_bucket_server_side_encryption_configuration" "jericho-crc-site-encryption" {
	bucket = aws_s3_bucket.jericho-crc-site.id
	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
	}
}

resource "aws_s3_bucket_acl" "jericho-crc-site-acl" {
  bucket = aws_s3_bucket.jericho-crc-site.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "jericho-crc-site-versioning" {
	bucket = aws_s3_bucket.jericho-crc-site.id
	versioning_configuration {
		status = "Enabled"
	}
}

# jericho-crc-site-cloudfront-logs S3 bucket configuration
resource "aws_s3_bucket" "jericho-crc-site-cloudfront-logs" {
  bucket = "jericho-crc-site-cloudfront-logs"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Project = "jericho-crc-site"
    Purpose = "CloudFront logging"
  }
}
resource "aws_s3_bucket_acl" "jericho-crc-site-cloudfront-logs-acl" {
  bucket = aws_s3_bucket.jericho-crc-site-cloudfront-logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_versioning" "jericho-crc-site-cloudfront-logs-versioning" {
	bucket = aws_s3_bucket.jericho-crc-site-cloudfront-logs.id
	versioning_configuration {
		status = "Enabled"
	}
}

resource "aws_s3_bucket_policy" "jericho-crc-site-cloudfront-logging-policy" {
  bucket = aws_s3_bucket.jericho-crc-site-cloudfront-logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "delivery.logs.amazonaws.com"
      },
      Action = "s3:PutObject",
      Resource = "arn:aws:s3:::jericho-crc-site-cloudfront-logs/*",
      Condition = {
        StringEquals =  {
          "AWS:SourceAccount" = var.aws_account_id
        }			
      }
  	}]
  })
}

### NOT DONE