resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.INSTANCE_DEVICE_NAME["ubuntu_20_04_x86"]
  instance_type   = "t2.micro"
  key_name        = "mykey"
  security_groups = [aws_security_group.allow-ssh.id]
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public1.id, aws_subnet.main-public2.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}


