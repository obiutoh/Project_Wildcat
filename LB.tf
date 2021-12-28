# THE APPLICATION LOAD BALANCER


resource "aws_lb" "Web_ALoadbalancer" {
  name               = "transcorp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]

  subnet_mapping {
    subnet_id = aws_subnet.Web-Subnet-1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.Web-Subnet-2.id
  }

  enable_deletion_protection = false

  tags = {
    name = "Web_ALoadbalancer"
  }
}

# Target Group #

resource "aws_alb_target_group" "db-alb-trg" {
  name        = "alb-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.VPC-Project8.id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200,300"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# LISTENER ON PORT 80 WITH REDIRECT APPLICATION

resource "aws_lb_listener" "webswerver-alb-listener" {
  load_balancer_arn = aws_lb.Web_ALoadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.db-alb-trg.arn
  }
}

