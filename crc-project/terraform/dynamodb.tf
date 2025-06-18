resource "aws_dynamodb_table" "visitor_count" {
  name         = "crcVisitorCounter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "visitor_id"
  attribute {
    name = "visitor_id"
    type = "S"
  }
  tags = {
	  Name        = "VisitorCountTable"
  	Environment = "Production"
	}
}