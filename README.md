## configuration terraform pour déployer un container docker sur un domaine publique personnalisé

### Prerequis

- un utilisateur aws avec roles suffisant 
- aws cli - [installation & configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- terraform cli - [installation & configuration](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- un nom de domaine - "example.com"

### Deploiement
    0 - modifier l'user dans github/workflow/main.yml
    1 - modifier les variables dans deploy/terraform.tfvars
    2 - cd deploy
    3 - terraform init
    4 - terraform plan
    5 - terraform apply
    6 - commit la nouvelle app

### Suppresion de l'infrastructure
    terraform destroy
    ⚠️ si le cluster ne se supprime pas , il faut supprimer manuellement les services et tâches associés au cluster
### services activé
- fargate
- ecr
- ecs
- vpc
- route53
- load balancer
- ip elastic