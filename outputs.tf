output "USER_POOL_ID" {
  description = "The ID of the user pool"
  value       = var.cognito_user_pool_id
}

output "AWS_REGION" {
  value = data.aws_region.current.name
}

output "COGNITO_USER_IDS" {
  value = join(",", aws_cognito_user.default.*.id)
}

output "IAM_POLICY_COGNITO_ADMIN_CLIENT" {
  value = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cognito-idp:List*",
          "cognito-idp:Describe*",
          "cognito-idp:Get*",
          "cognito-idp:Admin*"
        ],
        Resource = "arn:aws:cognito-idp:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:userpool/${var.cognito_user_pool_id}"
      },
    ]
  })
}