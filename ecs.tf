resource "aws_ecs_cluster" "cluster_catdog" {
  name               = "cluster_catdog"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


resource "aws_ecs_task_definition" "taskcat1" {
  family                   = "taskcat"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::813627017350:role/AmazonECSTaskExecutionRolePolicy"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name  = "first-cat"
      image = "813627017350.dkr.ecr.us-east-1.amazonaws.com/cats"

      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }

  ])
}

resource "aws_ecs_task_definition" "taskdog1" {
  family                   = "taskdog"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::813627017350:role/AmazonECSTaskExecutionRolePolicy"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name  = "first-dog"
      image = "813627017350.dkr.ecr.us-east-1.amazonaws.com/dogs"

      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }

  ])
}


resource "aws_ecs_service" "ecs_taskcat1" {
  name            = "ecs_taskcat1"
  task_definition = aws_ecs_task_definition.taskcat1.arn
  cluster         = aws_ecs_cluster.cluster_catdog.id
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets          = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups  = [aws_security_group.allow_http.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.cat_tg.arn
    container_name   = "first-cat"
    container_port   = 80
  }
}




resource "aws_ecs_service" "ecs_taskdog1" {
  name            = "ecs_taskdog1"
  task_definition = aws_ecs_task_definition.taskdog1.arn
  cluster         = aws_ecs_cluster.cluster_catdog.id
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets          = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups  = [aws_security_group.allow_http.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.dog_tg.arn
    container_name   = "first-dog"
    container_port   = 80
  }
}




