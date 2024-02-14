
output "roles" {
  description = "Roles"
  value = tomap({
    "codebuild" : aws_iam_role.codebuild.arn,
    "codepipeline" : aws_iam_role.codepipeline.arn
  })
}