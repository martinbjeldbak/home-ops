# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GitOps-based home operations repository that manages a Kubernetes cluster deployed on Talos Linux. The infrastructure is declaratively managed using Flux CD with applications deployed via Helm charts and Kustomize manifests.

## Architecture

### Core Technologies
- **Talos Linux**: Immutable OS for Kubernetes nodes
- **Proxmox**: Talos nodes run within Proxmox as VMs
- **Kubernetes**: Container orchestration platform
- **Flux CD**: GitOps operator for continuous deployment
- **Cilium**: CNI and service mesh for networking
- **Helm**: Package manager for Kubernetes applications
- **SOPS**: Secret management with age encryption
- **1Password**: External secrets management via Connect API

### Key Components
- **CNI**: Cilium with BGP/L2 announcement policies
- **DNS**: CoreDNS with custom configurations
- **Ingress**: Cilium Gateway API with internal/external classes
- **Storage**: Proxmox CSI and NFS drivers
- **Observability**: Prometheus stack, Grafana, Loki, Alloy
- **Backup**: Volsync with Restic for persistent volumes
- **Database**: Cloudnative-pg for postgres databases


## Common Commands

### Development Environment
```bash
# Install tool dependencies
mise install
mise run deps

# Bootstrap cluster (first time)
task bootstrap:talos  # Install and configure Talos
task bootstrap:apps   # Deploy core applications via Flux
```

### Cluster Management
```bash
# Force Flux reconciliation
task reconcile
flux -n flux-system reconcile kustomization flux-system --with-source

# Apply Talos config to specific node
task talos:apply-node IP=192.168.1.101 MODE=auto

# Reset cluster (destructive)
task talos:reset
```

### Application Management
```bash
# Sync all external secrets
task kubernetes:sync-secrets

# Clean up failed/pending pods
task kubernetes:cleanse-pods

# Suspend/resume Volsync
task volsync:suspend
task volsync:resume

# Snapshot application volume
task volsync:snapshot NS=default APP=plex

# Restore from backup
task volsync:restore NS=default APP=plex PREVIOUS=20241201120000
```

### Debugging
```bash
# Check Flux status
flux get sources git -A
flux get kustomizations -A
flux get helmreleases -A

# View pod logs
kubectl -n <namespace> logs <pod> -f

# Describe resources
kubectl -n <namespace> describe <resource> <name>

# Check events
kubectl -n <namespace> get events --sort-by='.metadata.creationTimestamp'
```

## Directory Structure

### Core Infrastructure
- `kubernetes/bootstrap/`: Initial cluster bootstrap configuration
  - `talos/`: Talos configuration and patches
  - `helmfile.yaml`: Essential services deployment
- `kubernetes/apps/`: Application deployments organized by namespace
- `kubernetes/flux/`: Flux CD configuration and cluster management

### Configuration Files
- `Taskfile.yaml`: Main task definitions with includes
- `.taskfiles/`: Modular task definitions for different operations
- `.mise.toml`: Development tool versions and environment
- `.sops.yaml`: Secret encryption rules and age keys

### Key Patterns
- Applications follow structure: `app/`, `database/`, `redis/`, `ks.yaml`
- Helm values in `app/helm/values.yaml`
- Kustomizations in `app/kustomization.yaml`
- External secrets in `app/externalsecret.yaml`
- Database clusters use CNPG operator

## Secret Management

### SOPS Configuration
- Age encryption key: `age.key` (root directory)
- Encrypted files: `*.sops.yaml` or `*.secret.sops.yaml`
- Automatic encryption for specific regex patterns

### 1Password Integration
- Connect API for external secrets
- Vault references: `op://Kubernetes/secret-name/field`
- ClusterSecretStore configured for external-secrets operator

## Development Workflow

### Making Changes
1. Edit manifests in `kubernetes/apps/`
2. Test with `kubeconform` for validation
3. Commit changes - Flux will automatically reconcile
4. Monitor deployment: `watch kubectl get pods -A`

### Adding New Applications
1. Create namespace directory under `kubernetes/apps/`
2. Add `ks.yaml` for Kustomization
3. Include in parent namespace `kustomization.yaml`
4. Follow existing patterns for Helm/Kustomize structure

### Troubleshooting
- Check Flux reconciliation status first
- Verify SOPS secrets are properly encrypted
- Ensure external secrets are pulling from 1Password
- Review Talos node health and network connectivity

## Important Notes

- All secrets must be encrypted with SOPS before committing
- Talos nodes use secure boot and custom kernel parameters
- Backup strategy uses Volsync with Restic to external storage
- Cluster uses topology labels for Proxmox CSI integration
