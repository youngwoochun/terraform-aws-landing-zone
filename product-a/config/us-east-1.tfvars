region                  = "us-east-1"

bastion_instance_defaults = {
  instance_count              = 1
  ami                         = "ami-0e9089763828757e1"
  instance_type               = "t2.micro"
  key_name                    = ""
  user_data                   = ""
  ebs_optimized               = false
  monitoring                  = false
  iam_instance_profile        = ""
  associate_public_ip_address = true
  delete_on_termination       = true
}

#bastion_delete_on_termination        = "true"
#bastion_encrypted                    = "true"
#bastion_volume_size                  = "20"
#bastion_volume_type                  = "gp2"
