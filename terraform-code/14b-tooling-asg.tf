resource "aws_autoscaling_group" "tooling-asg" {
  name                      = "tooling-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1

  vpc_zone_identifier = [aws_subnet.PrivateSubnet-1.id, aws_subnet.PrivateSubnet-2.id]


  launch_template {
    id      = aws_launch_template.tooling-launch-template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tooling-tgt.arn]

  tag {
    key                 = "Name"
    value               = "kn-tooling"
    propagate_at_launch = true
  }

}