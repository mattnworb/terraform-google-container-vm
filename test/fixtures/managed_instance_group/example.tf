/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
locals {
  example_name = "managed-instance-group"
}
resource "tls_private_key" "gce-keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "gce-keypair-pk" {
  content  = tls_private_key.gce-keypair.private_key_pem
  filename = "${path.module}/ssh/key"
}
module "example" {
  source     = "../../../examples/managed_instance_group"
  project_id = var.project_id
  subnetwork = google_compute_subnetwork.main.name
  mig_name   = "cft-test-${local.example_name}-${random_string.suffix.result}"
  region     = var.region
  image_port = "8080"
  image      = "gcr.io/google-samples/hello-app:1.0"
  additional_metadata = {
    "sshKeys" = "user:${tls_private_key.gce-keypair.public_key_openssh}"
  }
}
