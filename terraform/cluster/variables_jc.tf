variable "pubsub1" {
  type = string
  default = "subnet-0400156864bc4188a"
}

variable "pubsub2" {
  type = string
  default = "subnet-015cf8d44040cb38b"
}

variable "eksIAMRole" {
  type = string
  default = "group4EKSCluster"
}

variable "EKSClusterName" {
  type = string
  default = "group4EKS_jc"
}

variable "k8sVersion" {
  type = string
  default = "1.30"
}

variable "workerNodeIAM" {
  type = string
  default = "group4WorkerNodes_jc"
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
  default = ["t2.micro"]
}

variable "environment" {
  type = string
  default = "dev"
}
