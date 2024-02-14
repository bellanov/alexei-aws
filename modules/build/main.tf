
resource "aws_codebuild_project" "build" {
  for_each       = var.builds
  name           = each.key
  description    = each.value.description
  build_timeout  = 10
  queued_timeout = 10

  service_role = var.codebuild_service_role

  source {
    type            = "GITHUB"
    location        = each.value.location
    buildspec       = "buildspec.yml"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "ARTIFACTS_BUCKET"
      value = var.artifacts_bucket
    }
  }
}

# resource "aws_codepipeline" "codepipeline" {
#   name     = "tf-test-pipeline"
#   role_arn = "arn:aws:iam::636334826710:role/codebuild"

#   artifact_store {
#     location = "codepipeline-j91qum17"
#     type     = "S3"
#   }

#   stage {
#     name = "Source"

#     action {
#       name             = "Source"
#       category         = "Source"
#       owner            = "AWS"
#       provider         = "CodeStarSourceConnection"
#       version          = "1"
#       output_artifacts = ["source_output"]

#       configuration = {
#         ConnectionArn    = "arn:aws:codestar-connections:us-east-1:636334826710:connection/8b3cdd50-8ac9-4326-8309-2fd35448e680"
#         FullRepositoryId = "bellanov/react-template"
#         BranchName       = "main"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       input_artifacts  = ["source_output"]
#       version          = "1"

#       configuration = {
#         ProjectName = "react-template"
#       }
#     }
#   }
# }