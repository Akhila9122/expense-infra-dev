locals {
  public_subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
  ami_id = data.aws_ami.ami_info.id
  vpn_sg_id = data.aws_ssm_parameter.vpn_sg_id.value

  common_tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}