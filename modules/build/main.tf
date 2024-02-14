
# resource "aws_codebuild_project" "build" {
#   name           = "test-codebuild-project"
#   description    = "test_codebuild_project_cache"
#   build_timeout  = 5
#   queued_timeout = 5

#   service_role = "arn:aws:iam::636334826710:role/codebuild"

#   artifacts {
#     type = "NO_ARTIFACTS"
#   }

#   environment {
#     compute_type                = "BUILD_GENERAL1_SMALL"
#     image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
#     type                        = "LINUX_CONTAINER"
#     image_pull_credentials_type = "CODEBUILD"

#     environment_variable {
#       name  = "SOME_KEY1"
#       value = "SOME_VALUE1"
#     }
#   }

#   source {
#     type            = "GITHUB"
#     location        = "https://github.com/bellanov/react-template.git"
#     git_clone_depth = 1
#   }

#   tags = {
#     Environment = "Test"
#   }
# }

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
#         ProjectName = "test"
#       }
#     }
#   }
# }