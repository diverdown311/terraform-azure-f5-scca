provider "azurerm" {
    version = "~> 2.1.0"
    features{}
}

provider acme {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

resource tls_private_key private_key {
  algorithm = "RSA"
}

resource acme_registration reg {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.cert_admin
}

resource acme_certificate certificate {
  account_key_pem           = acme_registration.reg.account_key_pem
  #common_name              = azurerm_public_ip.lbpip.name
  common_name               = "vmdo.usgovvirginia.cloudapp.usgovcloudapi.net"

  dns_challenge {
    provider = "azure"
  }
}