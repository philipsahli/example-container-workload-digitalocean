resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "cluster"
  region  = "fra1"
  version = "1.12.1-do.2"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.cluster.endpoint}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
}

resource "digitalocean_database_cluster" "db" {
  name       = "db-cluster"
  engine     = "pg"
  version    = "11"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}
