

resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups = [aws_security_group.elb-sg.id]
  listener {
    instance_port = 80 # 포트 번호 상관 없이 가능 
    # nodejs 서버가 3000 이라면
    # instance_port     = 3000   
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    # target은 자유롭게 바꿀수 있음
    # target              = "HTTP:3000/heath"
    interval = 30
  }

  instances                   = [aws_instance.example-instance.id]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }

}


# ELB + autoscaling
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.INSTANCE_DEVICE_NAME["ubuntu_20_04_x86"]
  instance_type   = "t2.micro"
  key_name        = "mykey"
  security_groups = [aws_security_group.allow-ssh.id]

  user_data = "#!/bin/bash\napt-get update -y\napt-get install -y nginx\nMYIP=`ifconfig | grep 'addre:10' | awk '{print $2}' | cut -d ':' -f2`\necho \"<h1>My IP: $MYIP</h1>\" > /var/www/html/index.html\nservice nginx start\n"
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public1.id, aws_subnet.main-public2.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  load_balancers            = [aws_elb.my-elb.name]
  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}
