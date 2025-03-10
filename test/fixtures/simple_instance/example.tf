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
  example_name = "simple"
}

module "example" {
  source = "../../../examples/simple_instance"

  project_id         = var.project_id
  subnetwork_project = var.project_id
  subnetwork         = google_compute_subnetwork.main.name
  instance_name      = "cft-test-${local.example_name}-${random_string.suffix.result}"
  region             = var.region
  zone               = var.zone
  client_email       = var.client_email
}
