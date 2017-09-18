provider "cloudca" {
   api_key = "${var.api_key}"
}

variable "api_key" {
   type="string"
}

variable "environment_id"{
   type="string"
}

variable "key_name"{
   type="string"
}

variable "student_count"{
   type="string"
}

variable "network_id"{
   type="string"
}

variable "vpc_id"{
   type="string"
}
