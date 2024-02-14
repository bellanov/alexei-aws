
# Assume Roles
#
# Define service roles to assume.
#================================================
data "aws_iam_policy_document" "assume_role_ec2" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "assume_role_codebuild" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "assume_role_codepipeline" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# CodeBuild
#
# Define CodeBuild Roles.
#================================================
resource "aws_iam_role" "codebuild" {
  name               = "codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_role_codebuild.json
}

data "aws_iam_policy_document" "codebuild" {

  statement {
    effect    = "Allow"
    actions   = ["codebuild:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:List*",
      "s3:PutObject",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:*",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "codestar-connections:UseConnection",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "codebuild" {
  name        = "codebuild-policy"
  description = "CodeBuild IAM Policy."
  policy      = data.aws_iam_policy_document.codebuild.json
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild.arn
}

# CodePipeline
#
# Define CodePipeline Role.
#================================================
resource "aws_iam_role" "codepipeline" {
  name               = "codepipeline"
  assume_role_policy = data.aws_iam_policy_document.assume_role_codepipeline.json
}

resource "aws_iam_policy" "codepipeline" {
  name        = "codepipeline-policy"
  description = "CodePipeline IAM Policy."
  policy      = data.aws_iam_policy_document.codebuild.json
}

resource "aws_iam_role_policy_attachment" "codepipeline" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.codepipeline.arn
}
