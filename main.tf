module "import_org" {
  source = "./import-org"

  providers = {
    aws.root = aws.assume-root-ireland
  }

}

module "detective_baseline_ireland" {
  source = "./modules/detective-baseline"

  depends_on = [module.import_org]

  providers = {
    aws.root  = aws.assume-root-ireland
    aws.audit = aws.assume-audit-ireland
  }

  delegated_admin   = var.audit_acc
  detective_org = module.import_org.org_member_accounts
}

module "detective_baseline_frankfurt" {
  source = "./modules/detective-baseline"

  depends_on = [module.import_org]

  providers = {
    aws.root  = aws.assume-root-frankfurt
    aws.audit = aws.assume-audit-frankfurt
  }

  delegated_admin   = var.audit_acc
  detective_org = module.import_org.org_member_accounts
}

module "detective_baseline_london" {
  source = "./modules/detective-baseline"

  depends_on = [module.import_org]

  providers = {
    aws.root  = aws.assume-root-london
    aws.audit = aws.assume-audit-london
  }

  delegated_admin   = var.audit_acc
  detective_org = module.import_org.org_member_accounts
}
