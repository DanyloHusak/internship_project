# Використовуємо провайдер Docker
provider "docker" {
  host = "npipe:////./pipe/docker_engine" # для Windows, замініть на unix:///var/run/docker.sock для Linux
}

resource "docker_registry" "docker_hub" {
  address  = "index.docker.io/v1/"
  username = "danylo2"   # замініть на ваше ім'я користувача DockerHub
  password = "1029384756"   # замініть на ваш пароль DockerHub
}

resource "docker_image" "frontend_image" {
  name         = "danylo2/internship_project-frontend:latest" # замініть на бажану назву образу
  build {
    context    = "${path.module}/frontend"   # шлях до папки з Dockerfile для frontend
    dockerfile = "${path.module}/frontend/Dockerfile"
  }
}

resource "docker_registry_image" "push_frontend_image" {
  name = docker_image.frontend_image.name
}