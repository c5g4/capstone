variable "pubsub1" {
  type = string
#   default = "subnet-0400156864bc4188a" # Prod
  default = "subnet-0130d4d2ec16d451b" # Dev
}

variable "pubsub2" {
  type = string
#   default = "subnet-015cf8d44040cb38b" # Prod
  default = "subnet-05b179fe5f65bf08a" # Dev
}

variable "eksIAMRole" {
  type = string
  default = "group4EKSCluster"
}

variable "EKSClusterName" {
  type = string
  default = "group4devEKS"
}

variable "k8sVersion" {
  type = string
  default = "1.28"
}

variable "workerNodeIAM" {
  type = string
  default = "group4WorkerNodes"
}

variable "max_size" {
  type = string
  default = 4
}

variable "desired_size" {
  type = string
  default = 3
}
variable "min_size" {
  type = string
  default = 3
}

variable "instanceType" {
  type = list
  default = ["t3.medium"] #["t2.micro"]
}

variable "environment" {
  type = string
  default = "prod"
}
