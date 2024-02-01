
# Get the policy by name
# TODO: Convert this into a resource that then outputs the name & arn
# Then export its ARN as an output
# data "aws_iam_policy" "required-policy" {
#   name = "AmazonS3FullAccess"
# }

# Create the role
# resource "aws_iam_role" "system-role" {
#   name = "data-stream-system-role"
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
# }


# Attach the policy to the role
# resource "aws_iam_role_policy_attachment" "attach-s3" {
#   role       = aws_iam_role.system-role.name
#   policy_arn = data.aws_iam_policy.required-policy.arn
# }