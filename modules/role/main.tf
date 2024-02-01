
# TODO: Create VPC Flow Logs role as an example
# resource "aws_iam_role" "role" {
#   name               = "test-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# assume_role_policy is required so consider parmeterizing here
# rather than polluting environments with data {} blocks
# resource "aws_iam_role" "test_role" {
#   name = "test_role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "tag-value"
#   }
# }

# resource "aws_iam_role_policy_attachment" "test-attach" {
#   role       = aws_iam_role.role.name
#   policy_arn = aws_iam_policy.policy.arn
# }

