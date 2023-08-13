resource "aws_alb" "my-alb" {
  name            = "my-alb"
  subnets         = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
  tags = {
    Name = "my-alb"

  }

}

resource "aws_alb_target_group" "frontend-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  tags = {
    Name = "frontend-target-group"
  }
}

resource "aws_alb_target_group_attachment" "frontend-attachment-1" {
  target_group_arn = aws_alb_target_group.frontend-target-group.arn
  target_id        = aws_instance.example-instance1.id
  port             = 80
}

# resource "aws_alb_target_group_attachment" "frontend-attachment-2" {
#   target_group_arn = aws_alb_target_group.frontend-target-group.arn
#   target_id        = aws_instance.example-instance2.id
#   port             = 80
# }

resource "aws_alb_listener" "frontend-listener" {
  load_balancer_arn = aws_alb.my-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.frontend-target-group.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "frontend-listener-rule" {
  listener_arn = aws_alb_listener.frontend-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.new-target-group.arn
  }

  condition {
    field  = "path-pattern"
    values = ["/static/*"]
  }
}

resource "aws_alb_target_group" "new-target-group" {
  name     = "new-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  tags = {
    Name = "new-target-group"
  }
}
