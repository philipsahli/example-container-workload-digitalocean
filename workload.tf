resource "kubernetes_service" "nginx" {
    metadata {
        name = "nginx-example"
    }
    spec {
        selector {
            app = "${kubernetes_pod.test.metadata.0.labels.app}"
        }
        port {
            port = 80
            target_port = 80
        }
        type = "LoadBalancer"
    }
}

resource "kubernetes_pod" "test" {
  metadata {
    name = "terraform-example"
    labels = {
        app = "MyApp"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

      env {
        name  = "environment"
        value = "test"
      }
    }
  }
}
