resource "aws_lb" "backend" {
  name            = "private"
  internal        = true
  security_groups = ["${aws_security_group.sg_22.id}"]
  subnets         = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
resource "aws_lb_listener" "backend" {
  load_balancer_arn = "${aws_lb.backend.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_backend_tg.arn}"
  }
}

resource "aws_alb_target_group" "alb_backend_tg" {
  name     = "alb-backend"
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

resource "aws_alb_target_group_attachment" "alb_backend-02_http" {
  target_group_arn = "${aws_alb_target_group.alb_backend_tg.arn}"
  target_id        = "${aws_instance.db.id}"
  port             = 80
}
