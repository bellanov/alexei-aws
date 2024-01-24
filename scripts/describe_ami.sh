#!/bin/bash
#
# Retrieve AMI image information.
# 
# USAGE:
# scripts/describe_ami.sh us-east-1 ami-97785bed
REGION=$1
AMI_ID=$2

aws ec2 describe-images --region ${REGION} --image-ids ${AMI_ID}