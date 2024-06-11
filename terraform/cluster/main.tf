terraform {
  backend "s3" {
    bucket = "group4s3"
    key    = "eks-terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_iam_role" "eks-iam-role" {
  name = var.eksIAMRole

  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_eks_cluster" "eks" {
  name = var.EKSClusterName
  role_arn = aws_iam_role.eks-iam-role.arn

  enabled_cluster_log_types = ["api", "audit", "scheduler", "controllerManager"]
  version = var.k8sVersion
  vpc_config {
    subnet_ids = [var.pubsub1, var.pubsub2]
  }

  // By Jeremy 2024-06-09
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role.eks-iam-role,
  ]
}

// By Jeremy 2024-06-09
resource "aws_eks_access_entry" "cmcheung001" {
  cluster_name      = aws_eks_cluster.eks.name
  principal_arn     = "arn:aws:iam::255945442255:user/cmcheung001"
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "cmcheung001" {
  cluster_name      = aws_eks_cluster.eks.name
  principal_arn     = "arn:aws:iam::255945442255:user/cmcheung001"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type       = "cluster"
  }
} 
resource "aws_iam_role" "workernodes" {
  name = var.workerNodeIAM

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy-eks" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.workernodes.name
}

// By Jeremy 2024-06-09 - name the created EC2

resource "aws_launch_template" "eks_launch_template" {
  name = "eks-launch-template"
  //instance_type = "t2.micro"

  tag_specifications {  
    resource_type = "instance"
    tags = {
      Name = "ce5-group4-eks-worker-node-Prod"  # Specify the name tag for the worker nodes
    }
  }
}

// By Jeremy 2024-06-09 - name the created EC2


resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "workernodes-${var.environment}"
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = [var.pubsub1, var.pubsub2]
  instance_types = var.instanceType

  // By Jeremy 2024-06-09 - name the created EC2
  launch_template {
    name = aws_launch_template.eks_launch_template.name
    version = "$Latest"
  }
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
}

