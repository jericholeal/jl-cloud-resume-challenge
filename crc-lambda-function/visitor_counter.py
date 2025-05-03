# Import required libraries

import boto3
import json
import os
from botocore.exceptions import ClientError

# Set up Environment Variables (set these in Lambda console under "Configuration" > "Environment Variables")
# These replace hardcoded values  and allow easy config changes without editing code
TABLE_NAME = os.environ.get("crcVisitorCounter", "defaultTableName")
PARTITION_KEY = os.environ.get("PARTITION_KEY", "id")
PARTITION_VALUE = os.environ.get("PARTITION_VALUE", "visitorCounter")
COUNTER_ATTRIBUTE = os.environ.get("COUNTER_ATTRIBUTE", "visitCount")

# Initialize DynamoDB service client using boto3
dynamodb = boto3.resource("dynamodb")

# Connect to specific table using its name
table = dynamodb.Table(TABLE_NAME)


def increment_visitor_count():
    """
    Increments the visit counter in the DynamoDB table and returns the updated value.
    """
    try:
        # 'ADD' expression adds 1 to the current visitCount attribute
        # Key: which item in the table to update
        response = table.update_item(
            Key={PARTITION_KEY: PARTITION_VALUE}, # Looks for the item with the id="visitorCounter"
            UpdateExpression=f"ADD {COUNTER_ATTRIBUTE} :incr", # Increments the visitCount attribute by 1
            ExpressionAttributeValues={":incr": 1}, # Defines how much to increment by
            ReturnValues="UPDATED_NEW" # Asks DynamoDB to return the updated attributes
        )

        # Pull the updated count from the response
        return response["Attributes"][COUNTER_ATTRIBUTE]
    
    except ClientError as e:
        # If the DynamoDB request fails, print and raise the error to be handled by the main function
        print(f"DynamoDB update failed: {e.response['Error']['Message']}")
        raise

def lambda_handler(event, context):
    """
    Entry point for the Lambda function. Triggered by API Gateway when a request is made.
    This function updates the visitor count and returns the new value.
    """
    try:
        # Call the function to update the count in DynamoDB
        updated_count = increment_visitor_count()

        # Create a successful HTTP response with CORS headers so browsers don't block it
        return {
            "statusCode": 200, # HTTP 200 = OK
            "headers": {
                "Access-Control-Allow-Origin": "*", # Allows any site to make the request (CORS)
                "Access-Control-Allow-Headers": "Content-Type"
            },
            "body": json.dumps({"count": updated_count}) # Send back the new count in JSON format
        }
    
    except Exception as e:
        # If anything goes wrong (network, DynamoDB, etc.), return a 500 Internal Server Error
        print(f"Error in lambda_handler:{str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal Server Error"})
        }
    

