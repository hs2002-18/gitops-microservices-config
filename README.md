# GitOps Microservices Deployment

A Kubernetes-based GitOps project for deploying a containerized microservices application across **Dev and Prod environments** using **Helm, Argo CD, Argo Rollouts, Prometheus and Grafana**.

This project demonstrates a complete **CI/CD + GitOps workflow**, where application images are built and published through a separate CI/CD repository and Kubernetes deployments are managed through this GitOps repository.

> **AI-Assisted Development:**
> This project was developed with the assistance of AI tools for architecture discussions, troubleshooting, configuration guidance, documentation, and development support. All configurations and deployments were tested and validated during implementation.

---

## Related Repository

### Repo 1 — Application CI/CD

**Repository:** [ADD REPO 1 LINK HERE]

Repo 1 is responsible for:

* Application source code
* GitHub Actions CI/CD
* Building Docker images
* Publishing Docker images to Docker Hub

This repository (**Repo 2**) is responsible for:

* Kubernetes deployment configuration
* Helm-based deployments
* Dev and Prod environments
* Argo CD GitOps deployment
* Argo Rollouts
* Prometheus and Grafana observability
* Argo CD notifications

---

## Project Flow

```text
                         Repo 1
                    Application Source
                           │
                           ▼
                    GitHub Actions
                           │
                           ▼
                     Docker Build
                           │
                           ▼
                       Docker Hub
                           │
                           ▼
                         Repo 2
                   GitOps Configuration
                           │
                           ▼
                        Argo CD
                           │
                  ┌────────┴────────┐
                  │                 │
                  ▼                 ▼
             gitops-dev        gitops-prod
                  │                 │
                  ▼                 ▼
              Helm Chart        Helm Chart
                  │                 │
                  ▼                 ▼
                 Dev               Prod
                  │                 │
                  └────────┬────────┘
                           ▼
                    Argo Rollouts
                           │
                           ▼
                 Progressive Deployment

              Prometheus ─────► Grafana
```

**Repo 1** builds and publishes the application Docker image.

**Repo 2** contains the desired Kubernetes state, which is continuously reconciled by Argo CD.

---

## Repository Structure

```text
.
├── argocd
│   ├── applications
│   │   ├── dev.yml
│   │   ├── observability.yml
│   │   └── prod.yml
│   ├── app-of-apps.yml
│   └── project.yml
│
├── helm
│   └── gitops-app
│       ├── Chart.yaml
│       ├── templates
│       │   ├── backend-deployment.yaml
│       │   ├── backend-service.yaml
│       │   ├── frontend-deployment.yaml
│       │   ├── frontend-service.yaml
│       │   ├── ingress.yaml
│       │   ├── namespace.yaml
│       │   ├── redis-deployment.yaml
│       │   └── redis-service.yaml
│       ├── values-dev.yaml
│       ├── values-prod.yaml
│       └── values.yaml
│
├── notifications
│   └── notification-config.yml
│
└── observability
    ├── grafana
    │   ├── deployment.yml
    │   └── service.yml
    └── prometheus
        ├── config.yml
        ├── deployment.yml
        ├── namespace.yml
        └── service.yml
```

---

## Technologies Used

| Technology     | Purpose                          |
| -------------- | -------------------------------- |
| Kubernetes     | Container orchestration          |
| Kind           | Local Kubernetes cluster         |
| Docker         | Application containerization     |
| Docker Hub     | Container image registry         |
| GitHub Actions | CI/CD automation                 |
| Helm           | Kubernetes application packaging |
| Argo CD        | GitOps continuous delivery       |
| Argo Rollouts  | Progressive deployment           |
| Prometheus     | Metrics collection               |
| Grafana        | Metrics visualization            |

---

## Dev and Prod Environments

Argo CD manages two application environments:

* `gitops-dev`
* `gitops-prod`

Both environments use the same Helm chart with environment-specific values:

```text
gitops-dev  → values-dev.yaml
gitops-prod → values-prod.yaml
```

This allows Dev and Prod to maintain separate configuration while reusing the same Kubernetes deployment templates.

---

## Helm

The application is packaged as a Helm chart:

```text
helm/gitops-app/
```

The chart contains Kubernetes resources for:

* Backend
* Frontend
* Redis
* Services
* Ingress
* Namespace

Environment-specific configuration is maintained using:

```text
values-dev.yaml
values-prod.yaml
```

---

## Argo CD

Argo CD provides the GitOps continuous delivery layer.

The configuration is located under:

```text
argocd/
├── applications/
│   ├── dev.yml
│   ├── observability.yml
│   └── prod.yml
├── app-of-apps.yml
└── project.yml
```

The project uses the **App-of-Apps pattern** to manage the individual Argo CD applications for:

* Dev
* Prod
* Observability

Argo CD continuously compares the desired state stored in Git with the actual Kubernetes state.

---

## Argo Rollouts

The backend uses **Argo Rollouts** for progressive deployment.

The Rollout configuration is integrated into the Helm deployment configuration under:

```text
helm/gitops-app/templates/
```

The progressive deployment was tested by changing the backend Docker image:

```text
1.0.0 → 1.1.0
```

The rollout behavior was then monitored and validated using Argo Rollouts.

---

## Notifications

Argo CD Notifications is configured through:

```text
notifications/
└── notification-config.yml
```

Notifications were configured for:

* Sync succeeded
* Sync failed

Email credentials are stored separately in Kubernetes Secrets and are not committed as plaintext credentials to Git.

The notification system was tested successfully with email delivery.

---

## Observability

The project includes **Prometheus** and **Grafana** for monitoring.

### Prometheus

```text
observability/prometheus/
├── config.yml
├── deployment.yml
├── namespace.yml
└── service.yml
```

Prometheus is responsible for collecting metrics from the Kubernetes environment and applications.

### Grafana

```text
observability/grafana/
├── deployment.yml
└── service.yml
```

Grafana provides visualization of the collected metrics.

The observability stack is managed through:

```text
argocd/applications/observability.yml
```

---

# Commands

The following are the main **Kind, Kubernetes, Argo CD, Argo Rollouts, and Notifications** commands used during the implementation.

## Kind

Create the Kubernetes cluster:

```bash
kind create cluster --name gitops-cluster
```

Check Kind clusters:

```bash
kind get clusters
```

Check cluster nodes:

```bash
kubectl get nodes
```

---

## Kubernetes

Check cluster information:

```bash
kubectl cluster-info
```

Check nodes:

```bash
kubectl get nodes
```

Check namespaces:

```bash
kubectl get namespaces
```

Create a namespace:

```bash
kubectl create namespace <namespace>
```

Apply a Kubernetes manifest:

```bash
kubectl apply -f <file>.yaml
```

Apply manifests from a directory:

```bash
kubectl apply -f <directory>/
```

Check all resources:

```bash
kubectl get all -A
```

Check pods:

```bash
kubectl get pods -A
```

Check deployments:

```bash
kubectl get deployments -A
```

Check services:

```bash
kubectl get services -A
```

Check ingress:

```bash
kubectl get ingress -A
```

Check resources inside a namespace:

```bash
kubectl get all -n <namespace>
```

Describe a resource:

```bash
kubectl describe <resource> <name> -n <namespace>
```

View pod logs:

```bash
kubectl logs <pod-name> -n <namespace>
```

---

## Argo CD

Check Argo CD components:

```bash
kubectl get pods -n argocd
```

Check Argo CD applications:

```bash
kubectl get applications -n argocd
```

Check the Dev application:

```bash
kubectl get application gitops-dev -n argocd
```

Describe an application:

```bash
kubectl describe application gitops-dev -n argocd
```

Get application YAML:

```bash
kubectl get application gitops-dev -n argocd -o yaml
```

List applications using the Argo CD CLI:

```bash
argocd app list
```

Get application details:

```bash
argocd app get gitops-dev
```

Check configured repositories:

```bash
argocd repo list
```

---

## Argo CD App-of-Apps

Apply the Argo CD project:

```bash
kubectl apply -f argocd/project.yml
```

Apply the App-of-Apps:

```bash
kubectl apply -f argocd/app-of-apps.yml
```

Check the applications created by App-of-Apps:

```bash
kubectl get applications -n argocd
```

---

## Argo Rollouts

Check the Argo Rollouts controller:

```bash
kubectl get pods -n argo-rollouts
```

Check Rollout resources:

```bash
kubectl get rollouts -A
```

Check a specific Rollout:

```bash
kubectl get rollout <rollout-name> -n <namespace>
```

Watch Rollout progress:

```bash
kubectl argo rollouts get rollout <rollout-name> -n <namespace> --watch
```

Promote a Rollout:

```bash
kubectl argo rollouts promote <rollout-name> -n <namespace>
```

The backend rollout was tested using:

```text
1.0.0 → 1.1.0
```

---

## Argo CD Notifications

Check the Notifications controller:

```bash
kubectl get pods -n argocd \
  -l app.kubernetes.io/name=argocd-notifications-controller
```

Check Notifications controller logs:

```bash
kubectl logs -n argocd deployment/argocd-notifications-controller
```

Check configured notification triggers:

```bash
kubectl exec -n argocd deployment/argocd-notifications-controller -- \
  argocd admin notifications trigger get
```

Check the Notifications ConfigMap:

```bash
kubectl get cm argocd-notifications-cm -n argocd -o yaml
```

Check the configured email service:

```bash
kubectl get cm argocd-notifications-cm -n argocd \
  -o jsonpath='{.data.service\.email\.gmail}'
```

Check Notification Secret keys:

```bash
kubectl get secret argocd-notifications-secret -n argocd \
  -o jsonpath='{.data}' | jq 'keys'
```

---

## Verification Commands

Check all running pods:

```bash
kubectl get pods -A
```

Check Argo CD:

```bash
kubectl get pods -n argocd
```

Check Argo CD applications:

```bash
kubectl get applications -n argocd
```

Check Rollouts:

```bash
kubectl get rollouts -A
```

Check services:

```bash
kubectl get svc -A
```

Check ingress:

```bash
kubectl get ingress -A
```

---

## Key Features

* GitOps-based Kubernetes deployment
* Separate Dev and Prod environments
* Helm-based application deployment
* Argo CD continuous delivery
* Argo CD App-of-Apps pattern
* Progressive backend deployment using Argo Rollouts
* Docker image management through Docker Hub
* GitHub Actions CI/CD integration
* Argo CD email notifications
* Prometheus monitoring
* Grafana visualization
* Containerized microservices architecture
* AI-assisted development and troubleshooting

---

## Project Objectives

This project demonstrates practical implementation of:

* GitOps principles
* Kubernetes application deployment
* Continuous delivery
* Environment separation
* Helm-based deployments
* Progressive delivery
* Container image management
* CI/CD automation
* Kubernetes observability
* Monitoring with Prometheus and Grafana
* Argo CD application management

---

## Author

**Harsh Shrimali**

GitHub: https://github.com/hs2002-18
