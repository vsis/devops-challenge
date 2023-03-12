variable "k8s_namespaces" {
  type = map(object({
    labels      = map(string)
    annotations = map(string)
  }))
  default = {}
}

resource "kubernetes_namespace" "namespace" {
  for_each = var.k8s_namespaces

  metadata {
    name        = each.key
    labels      = each.value.labels
    annotations = each.value.annotations
  }
}
