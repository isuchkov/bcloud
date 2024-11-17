resource "kubernetes_horizontal_pod_autoscaler_v2" "hpa" {
  metadata {
    name      = var.hpa_name
    namespace = var.namespace
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = var.deployment_name
    }

    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    metric {
      type = "Resource"

      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = var.cpu_threshold
        }
      }
    }

    metric {
      type = "Resource"

      resource {
        name = "memory"
        target {
          type               = "Utilization"
          average_utilization = var.memory_threshold
        }
      }
    }
  }
}
