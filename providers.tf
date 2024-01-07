provider "aws" {
  alias  = "assume-audit-london"
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${var.audit_acc}:role/${var.tf_role}"
  }
}

provider "aws" {
  alias  = "assume-audit-ireland"
  region = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.audit_acc}:role/${var.tf_role}"
  }
}

provider "aws" {
  alias  = "assume-audit-frankfurt"
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.audit_acc}:role/${var.tf_role}"
  }
}

provider "aws" {
  alias  = "assume-root-london"
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${var.root_acc}:role/${var.tf_role}"
  }
}

provider "aws" {
  alias  = "assume-root-ireland"
  region = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.root_acc}:role/${var.tf_role}"
  }
}

provider "aws" {
  alias  = "assume-root-frankfurt"
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.root_acc}:role/${var.tf_role}"
  }
}
