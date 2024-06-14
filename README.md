# Capstone Project - Cohort 5 Group 4

## Team members: CHEONG Jia Hao (Leon), CHEUNG Chun Ming (Jeremy)

## Introduction
The capstone project bases on the AWS Containers Retail Sample (https://www.eksworkshop.com/docs/introduction/getting-started/about). We deploy the application into AWS EKS (Amazon Elastic Kubernetes Service) which is a managed Kubernetes service provided by Amazon Web Services (AWS). It allows users to run Kubernetes, an open-source system for automating the deployment, scaling, and management of containerized applications, without needing to install, operate, and maintain their own Kubernetes control plane or nodes.

![Screenshot](/docs/images/EKSCluster001.png)

Additional features are added into the sample application for use cases

### Use Case 1 - Continuous Integration and Continuous Delivery (CI/CD) Pipeline (DevOps)
1. 3 GitHub repositories are created and maintained for version control & CICD pipelines (https://github.com/c5g4?tab=repositories)
2. EKS deployment is done Terraform (https://github.com/c5g4/capstone.git) as Infrastructure as Code (IaC)
3. UI module development is done via CI pipeline by GitHub Action (https://github.com/c5g4/retail-store-app-ui.git)
4. UI module deployment is done via CD pipeline by ArgoCD (https://github.com/c5g4/retail-config.git) into AWS ECR (Amazon Elastic Container Registry)

GitHub:
![Screenshot](/docs/images/MainRepo001.png)

ECR:
![Screenshot](/docs/images/ECR001.png)

### Use Case 2 - Site Reliability Engineering (SRE)
5. Splunk monitoring is implemented.

### Use Case 3 - Security Focused (DevSecOps)
6. Code vulnerability scanning and quality assurance are automated in CI by Snyk test (pom.xml), Snyk IAC, mvn checkstyle & mvn verify (https://github.com/c5g4/retail-store-app-ui.git)


## AWS Containers Retail Sample
It is a sample application designed to illustrate various concepts related to containers on AWS. It presents a sample retail store application including a product catalog, shopping cart and checkout.

It provides:
- A distributed component architecture in various languages and frameworks
- Utilization of a variety of different persistence backends for different components like MySQL, DynamoDB and Redis
- The ability to run in various container orchestration technologies like Docker Compose, Kubernetes etc.
- Pre-built containers image for both x86-64 and ARM64 CPU architectures
- All components instrumented for Prometheus metrics and OpenTelemetry OTLP tracing
- Support for Istio on Kubernetes
- Load generator which exercises all of the infrastructure

**This project is intended for educational purposes only and not for production use.**

![Screenshot](/docs/images/screenshot.png)

## Application Architecture

The application has been deliberately over-engineered to generate multiple de-coupled components. These components generally have different infrastructure dependencies, and may support multiple "backends" (example: Carts service supports MongoDB or DynamoDB).

![Architecture](/docs/images/architecture.png)

| Component | Language | Container Image     | Description                                                                 |
|-----------|----------|---------------------|-----------------------------------------------------------------------------|
| ![ui workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-ui.yml/badge.svg)        | Java     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-ui)       | Aggregates API calls to the various other services and renders the HTML UI. |
| ![catalog workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-catalog.yml/badge.svg)   | Go       | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-catalog)  | Product catalog API                                                         |
| ![cart workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-cart.yml/badge.svg)   | Java     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-cart)     | User shopping carts API                                                     |
| ![orders workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-orders.yml/badge.svg)  | Java     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-orders)   | User orders API                                                             |
| ![checkout workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-checkout.yml/badge.svg) | Node     | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-checkout) | API to orchestrate the checkout process                                     |
| ![assets workflow](https://github.com/aws-containers/retail-store-sample-app/actions/workflows/ci-assets.yml/badge.svg)  | Nginx    | [Link](https://gallery.ecr.aws/aws-containers/retail-store-sample-assets)   | Serves static assets like images related to the product catalog             |


UI Architecture:

![Architecture](/docs/images/catalog-microservice-001.png)

Overall Architecture:

![Architecture](/docs/images/catalog-microservice-002.png)


## CI(GitHub) CD(ArgoCD) Flows

EKS / ArgoDA CI

![Screenshot](/docs/images/0001-capstone-infra.drawio.png)


UI CI CD

![Screenshot](/docs/images/0001-retail-store-app-ui.drawio.png)







