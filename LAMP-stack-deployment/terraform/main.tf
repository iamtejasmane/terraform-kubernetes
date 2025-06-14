# PHP image
resource "docker_image" "php-httpd-image" {
  name = "php-httpd"
  build {
    path = "stack/php_httpd"
    label = {
      stack = "lamp"
    }
  }
}

# MariaDB image

resource "docker_image" "mariadb-image" {
  name = "mariadb"
  build {
    path = "stack/db"
    label = {
      stack = "lamp"
    }
  }
}

# Docker container for php webserver
resource "docker_container" "php-httpd" {
  name     = "webserver"
  hostname = "php-httpd"
  image    = "php-httpd"
  labels {
    label = "stack"
    value = "lamp"
  }
  network_mode = "my_network"
  ports {
    external = "80"
    internal = "80"
  }

  volumes {
    host_path      = "LAMP-stack-deployment/stack/app/"
    container_path = "/var/www/html"
  }

}

# Docker container for php webserver
resource "docker_container" "phpmyadmin" {
  name     = "db_dashboard"
  hostname = "phpmyadmin"
  image    = "phpmyadmin/phpmyadmin"
  labels {
    label = "stack"
    value = "lamp"
  }
  network_mode = "my_network"
  ports {
    external = "8081"
    internal = "80"
  }
  depends_on = [docker_container.mariadb]
  # deprecated
  links = ["db", "db_dashboard"]

}

# Docker container for mariadb
resource "docker_container" "mariadb" {
  name     = "db"
  hostname = "db"
  image    = "mariadb:stack"
  labels {
    label = "stack"
    value = "lamp"
  }
  network_mode = "my_network"
  ports {
    external = "3306"
    internal = "3306"
  }
  env   = ["MYSQL_ROOT_PASSWORD=1234", "MYSQL_DATABASE=simple-website"]
  links = ["db", "db_dashboard"]

  volumes {
    volume_name    = docker_volume.mariadb_volume.name
    container_path = "/var/lib/mysql"
  }

}

resource "docker_volume" "mariadb_volume" {
  name = "mariadb-volume"
}

resource "docker_network" "private_network" {
  name       = "my_network"
  attachable = true
  labels {
    label = "stack"
    value = "lamp"
  }
}