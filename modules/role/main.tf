
# TODO: Create VPC Flow Logs role as an example
# resource "aws_iam_role" "role" {
#   name               = "test-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "test-attach" {
#   role       = aws_iam_role.role.name
#   policy_arn = aws_iam_policy.policy.arn
# }