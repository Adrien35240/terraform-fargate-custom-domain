# data "aws_ecr_image" "test" {
#   repository_name = aws_ecr_repository.test.name
#   image_tag = "latest"
# }

resource "aws_ecs_task_definition" "test" {
    family = "backend_example_app_family"

    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    memory = "512"
    cpu = "256"
    execution_role_arn = "${aws_iam_role.ecs_role.arn}"
    
    container_definitions = <<EOT
[
    {
        "name": "test_container",
        "image": "${aws_ecr_repository.test.repository_url}:latest",
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

resource "aws_ecs_cluster" "test" {
    name = "test"
}

resource "aws_ecs_service" "test" {
    name = "test"
    force_new_deployment = true
    cluster = "${aws_ecs_cluster.test.id}"
    task_definition = "${aws_ecs_task_definition.test.arn}"
    launch_type = "FARGATE"
    desired_count = 1
    load_balancer {
      target_group_arn = aws_lb_target_group.test-tg.arn
      container_name = "test_container"
      container_port = 80
    }
    network_configuration {
        subnets = ["${aws_subnet.public_a.id}"]
        security_groups = ["${aws_security_group.test.id}"]
        assign_public_ip = true
    }
}
