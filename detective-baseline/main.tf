locals {
  temp = [
    for x in var.detective_org :
    x if x.id != var.delegated_admin && x.status == "ACTIVE"
  ]
}

resource "aws_detective_graph" "detective_graph" {
    provider = aws.audit

    depends_on = [ aws_detective_organization_admin_account.detective_org_admin ]
}

resource "aws_detective_organization_configuration" "detective_org_config" {
  provider    = aws.audit

  depends_on  = [aws_detective_graph.detective_graph]

  auto_enable = true
  graph_arn   = aws_detective_graph.detective_graph.id
}

resource "aws_organizations_organization" "detective_graph_feature" {
  provider                      = aws.root

  aws_service_access_principals = ["detective.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_detective_organization_admin_account" "detective_org_admin" {
  provider = aws.root

  depends_on = [aws_organizations_organization.detective_graph_feature]

  account_id = var.delegated_admin
}

resource "aws_detective_member" "detective_member" {
  provider = aws.audit

  depends_on = [aws_detective_graph.detective_graph]
  count      = length(local.temp)

  account_id                 = local.temp[count.index].id
  email_address              = local.temp[count.index].email_address
  graph_arn                  = aws_detective_graph.detective_graph.graph_arn
  disable_email_notification = true
}
