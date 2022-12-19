#!/bin/bash
#
# Create a bucket to manage Terraform state.
ACCOUNT='development-1'
TIMESTAMP=$(date +%s)
BUCKET_NAME=$ACCOUNT'-tf-'$TIMESTAMP
REGION='us-east-1'

echo "Creating environment backend bucket..."
echo "Bucket Name: $BUCKET_NAME"
aws s3api create-bucket \
    --bucket ${BUCKET_NAME} \
    --region ${REGION}
