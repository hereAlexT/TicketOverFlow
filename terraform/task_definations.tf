resource "aws_ecs_task_definition" "concert" {
  family                   = "concert"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = data.aws_iam_role.lab.arn

  container_definitions = jsonencode([
    {
      name         = "concert"
      image        = "${aws_ecr_repository.concert.repository_url}:${var.image_version}"
      essential    = true
      cpu          = 512
      memory       = 1024
      portMappings = [
        {
          containerPort = 7777
          hostPort      = 7777
        }
      ]
      environment : [
        {
          name  = "SQLALCHEMY_DATABASE_URI"
          value = "${local.rds_uri}/ticketoverflow"
        },
        {
          name  = "SERVICE_HAMILTON_URL"
          value = local.hamilton_endpoint
        },
        {
          name  = "SERVICE_TICKET_URL"
          value = local.ticket_endpoint
        },
        {
          name  = "SERVICE_USER_URL"
          value = local.user_endpoint
        },
        {
          name  = "SERVICE_CONCERT_URL"
          value = local.concert_endpoint
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "concert"
        }
      }
    }
  ])

}

resource "aws_ecs_task_definition" "ticket" {
  family                   = "ticket"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = data.aws_iam_role.lab.arn

  container_definitions = jsonencode([
    {
      name         = "ticket"
      image        = "${aws_ecr_repository.ticket.repository_url}:${var.image_version}"
      essential    = true
      cpu          = 512
      memory       = 1024
      portMappings = [
        {
          containerPort = 9999
          hostPort      = 9999
        }
      ]
      environment : [
        {
          name  = "SQLALCHEMY_DATABASE_URI"
          value = "${local.rds_uri}/ticketoverflow"
        },
        {
          name  = "SERVICE_HAMILTON_URL"
          value = local.hamilton_endpoint
        },
        {
          name  = "SERVICE_TICKET_URL"
          value = local.ticket_endpoint
        },
        {
          name  = "SERVICE_USER_URL"
          value = local.user_endpoint
        },
        {
          name  = "SERVICE_CONCERT_URL"
          value = local.concert_endpoint
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ticket"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "user" {
  family                   = "user"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = data.aws_iam_role.lab.arn

  container_definitions = jsonencode([
    {
      name         = "user"
      image        = "${aws_ecr_repository.user.repository_url}:${var.image_version}"
      essential    = true
      cpu          = 512
      memory       = 1024
      portMappings = [
        {
          containerPort = 8888
          hostPort      = 8888
        }
      ]
      environment : [
        {
          name  = "SQLALCHEMY_DATABASE_URI"
          value = "${local.rds_uri}/ticketoverflow"
        },
        {
          name  = "SERVICE_HAMILTON_URL"
          value = local.hamilton_endpoint
        },
        {
          name  = "SERVICE_TICKET_URL"
          value = local.ticket_endpoint
        },
        {
          name  = "SERVICE_USER_URL"
          value = local.user_endpoint
        },
        {
          name  = "SERVICE_CONCERT_URL"
          value = local.concert_endpoint
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "user"
        }
      }
    }
  ])
}