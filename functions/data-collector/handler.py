import json

def lambda_handler(event, context):
    print("New version of data collector")
    return {
        "statusCode": 200,
        "body": json.dumps({"ok": True, "service": "data-collector"})
    }
