resource "helm_release" "redis_sentinel" {
  name       = "redis-sentinel"
  chart      = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = var.namespace

  values = [
    <<EOF
sentinel:
  enabled: true
replica:
  replicaCount: 3
master:
  persistence:
    enabled: true
EOF
  ]
}
