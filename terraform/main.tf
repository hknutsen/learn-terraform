resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "example_key" {
  filename = "${path.module}/../infra/example.key"
  content  = tls_private_key.example.private_key_pem
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
  ]
}

resource "local_sensitive_file" "example_cert" {
  filename = "${path.module}/../infra/example.crt"
  content  = tls_self_signed_cert.example.cert_pem
}
