
# data "aws_iam_policy_document" "instance_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "example" {
#   name                = "yak_role"
#   assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
#   managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
# }

# resource "aws_iam_policy" "assume_ec2" {
#   name = "policy-618033"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = ["ec2:Describe*"]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_policy" "policy_two" {
#   name = "policy-381966"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }