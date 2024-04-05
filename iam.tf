# Creating IAM User

resource "aws_iam_user" "kops-user" {
  name = "kops-user"
}

resource "aws_iam_group" "kops-group" {
  name = "kops-group"
}

resource "aws_iam_user_group_membership" "member-user-group" {
  user = aws_iam_user.kops-user.name

  groups = [
    aws_iam_group.kops-group.name
  ]
}

resource "aws_iam_policy" "S3_policy" {
  name = "S3-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "ec2_policy" {
  name = "ec2-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "route53_policy" {
  name = "route53_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "route53:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "iam_policy" {
  name = "iam-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "Sqs_policy" {
  name = "Sqs_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "events_policy" {
  name = "events-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "events:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "vpc_policy" {
  name = "vpc-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "vpc:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "s3-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.S3_policy.arn
}
resource "aws_iam_group_policy_attachment" "ec2-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}
resource "aws_iam_group_policy_attachment" "events-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.events_policy.arn
}
resource "aws_iam_group_policy_attachment" "iam-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.iam_policy.arn
}
resource "aws_iam_group_policy_attachment" "route53-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.route53_policy.arn
}
resource "aws_iam_group_policy_attachment" "sqs-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.Sqs_policy.arn
}
resource "aws_iam_group_policy_attachment" "vpc-attach" {
  group      = aws_iam_group.kops-group.name
  policy_arn = aws_iam_policy.vpc_policy.arn
}