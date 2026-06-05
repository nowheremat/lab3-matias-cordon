> $ kubectl cluster-info 
```
Kubernetes control plane is running at https://127.0.0.1:63576
CoreDNS is running at https://127.0.0.1:63576/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

> $ kubectl get nodes
>
```
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   15d   v1.35.1
```

> $ kubectl get pods -n ns-matias-cordon
>
```
NAME                                 READY   STATUS    RESTARTS   AGE
app-matias-cordon-5fb6dfb899-48dgq   1/1     Running   0          44s
app-matias-cordon-5fb6dfb899-bk8tr   1/1     Running   0          56s
```

> $ kubectl get deployment -n ns-matias-cordon
```
NAME                READY   UP-TO-DATE   AVAILABLE   AGE
app-matias-cordon   2/2     2            2           15m
```

> $ kubectl get svc -n ns-matias-cordon
```
NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
svc-matias-cordon   ClusterIP   10.102.44.206   <none>        80/TCP    16m
```

> $ kubectl logs deployment/app-matias-cordon -n ns-matias-cordon
```
Found 2 pods, using pod/app-matias-cordon-5fb6dfb899-bk8tr
[Nest] 1  - 06/05/2026, 4:40:59 AM     LOG [NestFactory] Starting Nest application...
[Nest] 1  - 06/05/2026, 4:40:59 AM     LOG [InstanceLoader] AppModule dependencies initialized +12ms
[Nest] 1  - 06/05/2026, 4:40:59 AM     LOG [RoutesResolver] AppController {/}: +4ms
[Nest] 1  - 06/05/2026, 4:40:59 AM     LOG [RouterExplorer] Mapped {/, GET} route +75ms
[Nest] 1  - 06/05/2026, 4:40:59 AM     LOG [RouterExplorer] Mapped {/lab, GET} route +1ms
[Nest] 1  - 06/05/2026, 4:40:59 AM     LOG [NestApplication] Nest application successfully started +2ms
```

> $ kubectl exec deployment/app-matias-cordon -n ns-matias-cordon -- printenv
```
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=app-matias-cordon-5fb6dfb899-bk8tr
PORT=3000
APP_VERSION=3.0.0
NODE_ENV=production
AMBIENTE=produccion
API_KEY=s3cr3t-matias-cordon
SVC_MATIAS_CORDON_PORT_80_TCP_PORT=80
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
SVC_MATIAS_CORDON_SERVICE_HOST=10.102.44.206
SVC_MATIAS_CORDON_PORT_80_TCP_PROTO=tcp
SVC_MATIAS_CORDON_PORT_80_TCP_ADDR=10.102.44.206
KUBERNETES_SERVICE_PORT=443
KUBERNETES_PORT_443_TCP_PROTO=tcp
SVC_MATIAS_CORDON_SERVICE_PORT=80
SVC_MATIAS_CORDON_PORT=tcp://10.102.44.206:80
SVC_MATIAS_CORDON_PORT_80_TCP=tcp://10.102.44.206:80
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_PORT=tcp://10.96.0.1:443
NODE_VERSION=22.22.3
YARN_VERSION=1.22.22
HOME=/home/appuser
```

> $ kubectl get configmap config-matias-cordon -n ns-matias-cordon
```
NAME                   DATA   AGE
config-matias-cordon   1      36m
```

> $ kubectl get secret secret-matias-cordon -n ns-matias-cordon
```
NAME                   TYPE     DATA   AGE
secret-matias-cordon   Opaque   1      37m
```

> kubectl port-forward svc/svc-matias-cordon 8080:80 -n ns-matias-cordon
> > Forwarding from 127.0.0.1:8080 -> 3000
> 
> > Forwarding from [::1]:8080 -> 3000
>
> Después de hacer curl http://localhost:8080/lab:
>
> > Handling connection for 8080

Respuesta del curl:

> {"AMBIENTE":"produccion","API_KEY":"s3cr3t-matias-cordon"}%  