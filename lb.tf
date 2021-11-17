resource "aws_lb" "cat_lb" {
  name               = "cat-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
}

resource "aws_lb_target_group" "cat_tg" {
  name        = "cat-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc_tp.id
  tags = {
    Name      = "cat_lb"
    Terraform = "True"
  }
  depends_on = [aws_lb.cat_lb]
}

resource "aws_lb_listener" "cat_http" {
  load_balancer_arn = aws_lb.cat_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat_tg.arn
  }

}

resource "aws_lb" "dog_lb" {
  name               = "dog-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
}



resource "aws_lb_target_group" "dog_tg" {
  name        = "dog-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc_tp.id
  tags = {
    Name      = "dog_lb"
    Terraform = "True"
  }
  depends_on = [aws_lb.dog_lb]
}

resource "aws_lb_listener" "dog_http" {
  load_balancer_arn = aws_lb.dog_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dog_tg.arn
  }

}