variable "cloud_id" {
  type = string
  description = "Yandex Cloud ID"
  default = "b1g3jddf4nv5e9okle7p"
}

variable "folder_id" {
  type = string
  description = "Yandex Cloud folder"
  default = "b1ggoah947u3kc4j9m7i"
}

variable "IAM_token" {
  type = string
  description = "Yandex IAM token"
  sensitive = true
}

variable "image_id" {
  type = string
  description = "Image of the VM"
  default = "fd80qm01ah03dkqb14lc"
}

variable "subnet_id" {
  type = string
  description = "ID of the subnet"
  default = "e9bq7u62i4q21jq25n5j"
}

variable "zone" {
  type = string
  description = "Availability zone"
  default = "ru-central1-a"
}
