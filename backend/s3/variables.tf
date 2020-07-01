variable "bucket" {
  type = string
}

variable "acl" {
  type = string
}

variable "versioning" {
  type = bool
}

variable "lifecycle_rule" {
  type = bool
}

variable "dynamodb_name" {
  type = string
}

variable "read_capacity" {
  type = number
}

variable "write_capacity" {
  type = number
}

variable "hash_key" {
  type = string
}

variable "attribute_name" {
  type = string
}

variable "attribute_type" {
  type = string
}
