import json

def lambda_handler(event, context):
    job_id = event.get("job_id", "unknown")
    return {
        "statusCode": 200,
        "body": json.dumps({"ok": True, "service": "report-job", "job_id": job_id})
    }
