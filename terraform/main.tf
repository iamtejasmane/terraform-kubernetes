# Kubernetes Service

resource "kubernetes_service" "webapp-service" {
    metadata {
      name = "webapp-service"
    }
  spec {
    selector = {
     name = "webapp" 
    }
    port {
      port = 8080
      node_port = 30080
    }
    type = "NodePort"
  }
}

# Frontend app deployment 
resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      "name" = "frontend"
    }
  }
  spec {
    replicas = 4
    template {
        metadata {
          name = "webapp"
          labels = {
            "name" = "webapp"
          }
        }
      spec {
        container {
          image = "kodekloud/webapp-color:v1"
          name = "simple-webapp"
          port {
            container_port = 8080
          }
        }
      }
    }
  }

}