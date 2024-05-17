variable "pubsub1" {
  type = string
  default = "subnet-0130d4d2ec16d451b"
}

variable "pubsub2" {
  type = string
  default = "subnet-05b179fe5f65bf08a"
}

variable "eksIAMRole" {
  type = string
  default = "group2EKSCluster"
}

variable "EKSClusterName" {
  type = string
  default = "group2EKS"
}

variable "k8sVersion" {
  type = string
  default = "1.26"
}

variable "workerNodeIAM" {
  type = string
  default = "group2WorkerNodes"
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
  default = "prod"
}