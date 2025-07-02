resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  # you can paste the public key directly like this
  #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQzmrbRt6aA9Kuoje6ySFl2vIvUd0ZlZoO/D4GQYje1 ASUS@LAPTOP-1SPD23E9"
  public_key = file("~/.ssh/openvpn.pub")
  # ~ means windows home directory
}

resource "aws_instance" "vpn" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.public_subnet_id
  #key_name = "daws-84s" # make sure this key exist in AWS
  key_name = aws_key_pair.vpn.key_name
  user_data = file("user-data.sh")

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}


# module "vpn" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   key_name = aws_key_pair.vpn.key_name
#   name = "${var.project_name}-${var.environment}-vpn"

#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
#   # convert StringList to list and get first element
#   subnet_id = local.public_subnet_id
#    user_data = file("user-data.sh")
#   ami = data.aws_ami.ami_info.id
#   associate_public_ip_address = true

  
#   tags = merge(
#     var.common_tags,
#     {
#         Name = "${var.project_name}-${var.environment}-vpn"
#     }
#   )
# }

# output "vpn_ip" {
#   value       = module.vpn.public_ip
# } 