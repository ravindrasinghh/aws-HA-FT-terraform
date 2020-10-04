resource "aws_lb" "front_end" {
  name            = "test-lb-tf"
  internal        = false
  security_groups = ["${aws_security_group.sg_22.id}"]
  subnets         = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_front_https_tg.arn}"
  }
}

resource "aws_alb_target_group" "alb_front_https_tg" {
  name     = "alb-front-https"
  vpc_id   = "${aws_vpc.ravindravpc.id}"
  port     = "80"
  protocol = "HTTP"
  health_check {
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 5
    timeout             = 4
    matcher             = "200-308"
  }
}

resource "aws_alb_target_group_attachment" "alb_backend-01_http" {
  target_group_arn = "${aws_alb_target_group.alb_front_https_tg.arn}"
  target_id        = "${aws_instance.web.id}"
  port             = 80
}
