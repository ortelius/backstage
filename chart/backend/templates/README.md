# Installation

First you will need to install the secrets

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: postgres-secrets
  namespace: backstage
type: Opaque
stringData:
  POSTGRES_USER: backstage
  POSTGRES_PASSWORD:
---
apiVersion: v1
kind: Secret
metadata:
  name: backstage-secrets
  namespace: backstage
type: Opaque
data:
  GITHUB_TOKEN:
```

### 2. Add Helm Repo

```bash
helm repo add backstage https://ortelius.github.io/backstage
```

Update if required
```bash
helm repo update backstage
```

### 3. Install Helm Chart
```bash
helm install backstage ortelius/backstage
```
