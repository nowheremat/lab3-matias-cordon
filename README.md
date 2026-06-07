# Laboratorio 3 
**Alumno:** Matias Cordon  
**Cluster:** Minikube  

---

## 1. Pre-requisitos

- Yo usé minikube, pero podría ser otro
- Docker Desktop
- kubectl
- Jenkins

---

## 2. Iniciar Minikube

```bash
minikube start
minikube status
kubectl cluster-info
kubectl get nodes
```

---

## 4. Validación

### 4a. Build y push de la imagen Docker

```bash
export DOCKERHUB_USER=nowheremat 
export GITHUB_USER=nowheremat

docker build \
  -t $DOCKERHUB_USER/tarea-final:matias-cordon \
  -t $DOCKERHUB_USER/tarea-final:3.0.0 \
  -t ghcr.io/$GITHUB_USER/tarea-final:matias-cordon \
  .

docker login
docker push $DOCKERHUB_USER/tarea-final:matias-cordon
docker push $DOCKERHUB_USER/tarea-final:3.0.0

echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USER --password-stdin
docker push ghcr.io/$GITHUB_USER/tarea-final:matias-cordon
docker push ghcr.io/$GITHUB_USER/tarea-final:3.0.0
```

### 4b. Aplicar manifiestos Kubernetes

```bash
kubectl apply -f entrega.yaml

kubectl get all -n ns-matias-cordon
kubectl rollout status deployment/app-matias-cordon -n ns-matias-cordon
```

## 5. Comandos de evidencia obligatorios

Ejecutar comandos para evidencias y finalmente darle con curl

## 6. Configurar Jenkins

### 6a. Credenciales (Manage Jenkins → Credentials → Global)

| ID | Tipo | Descripción |
|----|------|-------------|
| `dockerhub-matias-cordon` | Username with password | Usuario y Access Token de Docker Hub |
| `github-token-matias-cordon` | Secret text | GitHub PAT con scope `write:packages` |

### 6b. Crear el pipeline

1. New Item → Pipeline → nombre: `Laboratorio3-Matias-Cordon`
2. Pipeline → Definition: Pipeline script from SCM
3. SCM: Git → URL del repositorio
4. Script Path: `Jenkinsfile.Matias-Cordon`
5. Guardar → **Build Now**

### 6c. Permisos kubectl para el agente Jenkins

```bash
kubectl create clusterrolebinding jenkins-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=jenkins:jenkins
```
Este último lo usé cuándo me tiró un error de permisos jenkins

---
