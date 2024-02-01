
# Get the policy by name
# TODO: Convert this into a resource that then outputs the name & arn
# Then export its ARN as an output

# data "aws_iam_policy_document" "policy" {
#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:Describe*"]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "policy" {
#   name        = "test-policy"
#   description = "A test policy"
#   policy      = data.aws_iam_policy_document.policy.json
# }
