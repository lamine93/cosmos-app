resource "azurerm_container_app" "app" {
  name                         = var.app_name
  resource_group_name          = var.rg_name
  container_app_environment_id = var.env_id
  revision_mode                = "Single"

  identity { type = "SystemAssigned" }

  registry {
    server   = var.acr_login_server
    identity = "system"
  }

  dynamic "secret" {
    for_each = var.secrets_from_kv
    content {
      name                = lower(replace(secret.key, "_", "-"))
      key_vault_secret_id = secret.value
      identity            = "System" 
    }
  }

  template {
    min_replicas = 1
    max_replicas = 2
    container {
      name   = "web"
      image  = var.image_ref
      cpu    = 0.5
      memory = "1Gi"

      dynamic "env" {
        for_each = var.env_plain
        content {
          name  = env.key
          value = env.value
        }
      }

      # Lier les secrets
      dynamic "env" {
        for_each = var.secrets_from_kv
        content {
          name        = env.key
          secret_name = lower(replace(env.key, "_", "-"))
        }
      }
    }
    http_scale_rule { 
        name = "httpscale"
        concurrent_requests = 50 
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.target_port
    transport        = "auto"
    traffic_weight { 
        latest_revision = true 
        percentage = 100 
    }
  }
}

