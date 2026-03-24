# Git-to-Kubernetes Automated CI/CD Pipeline 🚀

This repository demonstrates a complete **Continuous Integration and Continuous Deployment (CI/CD)** pipeline for a Python FastAPI microservice, deploying automatically to a Kubernetes (EKS) cluster using GitHub Actions.

## 🏭 Pipeline Overview

The automated workflow (`.github/workflows/deploy.yml`) is triggered on every push to the `main` branch:

1.  **Stage: Test 🧪**
    - Spins up a clean Python environment.
    - Installs dependencies.
    - Runs automated unit tests using **`pytest`**. If tests fail, the pipeline stops immediately, protecting production.
2.  **Stage: Build & Push 🏗️**
    - Logs into Docker Hub securely using GitHub Secrets.
    - Builds a production-ready Docker image using **Multi-stage build** optimization.
    - Pushes the image with a unique tag (git commit SHA) and a `latest` tag.
3.  **Stage: Deploy 🚀**
    - Configures `kubectl` access via GitHub Secrets (`KUBE_CONFIG`).
    - Dynamically updates the Kubernetes Deployment manifest with the new Docker image tag using `sed`.
    - Applies manifests to the cluster (`kubectl apply`), executing a **Rolling Update** with zero downtime.

## 🛠 Tech Stack & Best Practices

- **Backend:** Python FastAPI
- **Testing:** Pytest
- **CI/CD Tool:** GitHub Actions
- **Containerization:** **Docker (Multi-stage build, runs as Non-Root user for security)**
- **Orchestration:** Kubernetes (EKS)

## 🔑 Required GitHub Secrets

To make this pipeline work, the following secrets must be configured in repository settings:
- `DOCKERHUB_USERNAME`: Your Docker Hub login.
- `DOCKERHUB_TOKEN`: Your Docker Hub Access Token (Personal Access Token).
- `KUBE_CONFIG`: The complete content of your `~/.kube/config` file to access the EKS cluster (obtained after Project 1).