import boto3
import json
import os
import logging
from botocore.exceptions import ClientError
from datetime import datetime, timedelta

lambda_client = boto3.client('lambda')
dynamodb = boto3.client('dynamodb')

def lambda_handler(event, context):
    try:
                