variable "vpc_id" {
  type    = string
  default = "vpc-7df54000"
}

data "aws_subnet_ids" "tribes" {
  vpc_id = var.vpc_id
}
