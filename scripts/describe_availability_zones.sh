#!/bin/bash
#
# Retrieve the availability zones (AZs) for a given region.
# 
# USAGE:
# scripts/describe_availability_zones.sh us-east-1
REGION=$1

aws ec2 describe-availability-zones --region ${REGION}