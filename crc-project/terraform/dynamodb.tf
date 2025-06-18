resource "aws_dynamodb_table" "visitor_count" {
  name         = "crcVisitorCounter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
	  Name        = "VisitorCountTable"
  	Environment = "Production"
	}
}