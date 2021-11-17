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

resource "aws_ecs_task_definition" "taskcat2" {
  family                   = "taskcat"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::813627017350:role/AmazonECSTaskExecutionRolePolicy"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name  = "second-cat"
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

resource "aws_ecs_task_definition" "taskdog2" {
  family                   = "taskdog"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::813627017350:role/AmazonECSTaskExecutionRolePolicy"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name  = "second-dog"
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
  network_configuration {
    subnets         = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups = [aws_security_group.allow_http.id]
  }
}

resource "aws_ecs_service" "ecs_taskcat2" {
  name            = "ecs_taskcat2"
  task_definition = aws_ecs_task_definition.taskcat2.arn
  cluster         = aws_ecs_cluster.cluster_catdog.id
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups = [aws_security_group.allow_http.id]
  }
}


resource "aws_ecs_service" "ecs_taskdog1" {
  name            = "ecs_taskdog1"
  task_definition = aws_ecs_task_definition.taskdog1.arn
  cluster         = aws_ecs_cluster.cluster_catdog.id
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups = [aws_security_group.allow_http.id]
  }
} 

resource "aws_ecs_service" "ecs_taskdog2" {
  name            = "ecs_taskdog2"
  task_definition = aws_ecs_task_definition.taskdog2.arn
  cluster         = aws_ecs_cluster.cluster_catdog.id
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.subnet_public_one.id, aws_subnet.subnet_public_two.id]
    security_groups = [aws_security_group.allow_http.id]
  }
} 