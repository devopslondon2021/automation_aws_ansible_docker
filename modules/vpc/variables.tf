variable "projectName" {}

variable "cidr" { 
    default = "10.100.0.0/16"
}

variable "public_cidr" { 
    default = [
        "10.100.1.0/24",
        "10.100.2.0/24",
    ]
}

variable "private_cidr" { 
    default = [
        "10.100.10.0/24",
        "10.100.20.0/24",
    ]
}
