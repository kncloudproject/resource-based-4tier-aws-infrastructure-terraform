# launch template for bastion

resource "aws_launch_template" "bastion-launch-template" {
  name = "kn-bastion"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-020cba7c55df1f615"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "devops"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }


  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name = "bastion-launch-template"
    }
  }

  # user_data = filebase64("${path.module}/bin/bastion.sh")
}