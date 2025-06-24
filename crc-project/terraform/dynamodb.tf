resource "aws_dynamodb_table" "jericho_crc_site_visitor_count" {
  name         = "crcVisitorCounter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Project = "jericho_crc_site"
  }
}