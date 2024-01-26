#!/bin/bash
#
# Test a Load Balancer.
# 
SITE_ADDRESS=$(terraform output site_address)

watch curl -s $SITE_ADDRESS