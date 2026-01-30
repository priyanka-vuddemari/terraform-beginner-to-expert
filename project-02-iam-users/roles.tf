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

/*
we must iterate over exisitng roles and create different assume role policy for each role
in each policy , under identifiers we must specify only the users that have the permission to assume the role

*/

data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "assume_role_policy" {
  for_each = toset(keys(local.role_policies))
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [
        for user in local.users_from_yaml : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user.username}"
        if contains(user.roles, each.key)
      ]
    }
  }
}

resource "aws_iam_role" "roles" {
  for_each           = toset(keys(local.role_policies))
  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[each.value].json

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