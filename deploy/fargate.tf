data "aws_ecr_image" "wiremock" {
  repository_name = aws_ecr_repository.test.name
  image_tag = "latest"
}

resource "aws_ecs_task_definition" "backend_task" {
    family = "backend_example_app_family"

    // Fargate is a type of ECS that requires awsvpc network_mode
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    // Valid sizes are shown here: https://aws.amazon.com/fargate/pricing/
    memory = "512"
    cpu = "256"
    // Fargate requires task definitions to have an execution role ARN to support ECR images
    execution_role_arn = "${aws_iam_role.ecs_role.arn}"
    
    container_definitions = <<EOT
[
    {
        "name": "example_app_container",
        "image": "${aws_ecr_repository.test.repository_url}:${data.aws_ecr_image.wiremock.image_tag}@${data.aws_ecr_image.wiremock.image_digest}",
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ]
    }
]
EOT
}

resource "aws_ecs_cluster" "backend_cluster" {
    name = "backend_cluster_example_app"
}

resource "aws_ecs_service" "backend_service" {
    name = "backend_service"
    force_new_deployment = true
    cluster = "${aws_ecs_cluster.backend_cluster.id}"
    task_definition = "${aws_ecs_task_definition.backend_task.arn}"
    launch_type = "FARGATE"
    desired_count = 1
    load_balancer {
      target_group_arn = aws_lb_target_group.test-tg.arn
      container_name = "example_app_container"
      container_port = 80
    }
    network_configuration {
        subnets = ["${aws_subnet.public_a.id}"]
        security_groups = ["${aws_security_group.test.id}"]
        assign_public_ip = true
    }
}