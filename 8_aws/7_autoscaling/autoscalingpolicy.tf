
#sacle up alarm
resource "aws_autoscaling_policy" "example-cpu-policy" {
  name                   = "example-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  policy_type            = "SimpleScaling"

}


resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "example-cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.example-cpu-policy.arn]
}


#sacle down alarm 
resource "aws_autoscaling_policy" "example-cpu-policy-down" {
  name                   = "example-cpu-policy-down"
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-down" {
  alarm_name          = "example-cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.example-cpu-policy-down.arn]
}

# 경고 알림 메일
resource "aws_sns_topic" "example-cpu-sns" {
  name         = "sg-cpu-sns"
  display_name = "example ASG SBS topic"
}
# 이메일 구독 확인후 ARN, ID 입력 


resource "aws_autoscaling_notification" "example-notify" {
  group_names = [aws_autoscaling_group.example-autoscaling.name]
  topic_arn   = aws_sns_topic.example-cpu-sns.arn

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

}
