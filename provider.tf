#Connectin with aws
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_profile}"
}
