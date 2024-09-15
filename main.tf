terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key"
  type        = string
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "SSH_Key" {
  name = "SSH_Key"
}

# Create a new DigitalOcean project
resource "digitalocean_project" "VulnHub" {
  name        = "VulnHub"
  description = "Auto-deploy a vulnerable lab environment with Terraform into a Digital Ocean project."
  environment = "Development"
}

# Data source for the install script
data "template_file" "install_script" {
  template = file("${path.module}/vulnlab.sh")
}

# Data source to get the current IP address
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# Create a VPC
resource "digitalocean_vpc" "vuln_vpc" {
  name     = "vuln-vpc"
  region   = "lon1"
  ip_range = "10.0.0.0/16"
}

# Create a Droplet
resource "digitalocean_droplet" "vulndocker" {
  name      = "vulndocker"
  image     = "ubuntu-22-04-x64"
  size      = "s-1vcpu-1gb"
  region    = "lon1"
  user_data = data.template_file.install_script.rendered
  tags      = ["vulndocker"]

  ssh_keys = [data.digitalocean_ssh_key.Caldera.id]

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file(var.ssh_private_key_path)
  }
}

# Create a Firewall
resource "digitalocean_firewall" "vulnlab-sg" {
  name        = "vulnlab-sg"
  droplet_ids = [digitalocean_droplet.vulndocker.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "25"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "81"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "82"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "84"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "85"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "111"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "137"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "138"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "139"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "161"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "199"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "389"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "445"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "636"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "2049"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "4444"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "4567"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "4568"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "6200"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "6306"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "9306"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = [format("%s/32", trimspace(data.http.myip.response_body))]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
