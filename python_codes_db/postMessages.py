import boto3
import json


dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Messages')

def lambda_handler(event, context):
    table.put_item(Item=event)
    return {"code":200, "message":"Message added successfully"}