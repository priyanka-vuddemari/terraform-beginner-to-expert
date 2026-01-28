locals {
  role_policies = {
    readonly = [
      "ReadOnlyAccess"
    ]
    admin = [
      "AdministratorAccess"
    ]
    auditor = [
      "SecurityAudit"
    ]
    developer = [
      "AmazonS3FullAccess",
      "AmazonEC2FullAccess",
      "AmazonVPCFullAccess"
    ]
  }

  roles_policies_list = flatten([
    for role, policies in local.role_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]

  ])
}


data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_iam_role" "roles" {
  for_each           = toset(keys(local.role_policies))
  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

}

data "aws_iam_policy" "policies" {
  for_each = toset(local.roles_policies_list[*].policy)
  arn      = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_role_policy_attachment" "role_policy_attachments" {
  count      = length(local.roles_policies_list)
  role       = aws_iam_role.roles[local.roles_policies_list[count.index].role].name
  policy_arn = data.aws_iam_policy.policies[local.roles_policies_list[count.index].policy].arn
}


output "policies" {
  value = local.roles_policies_list
}