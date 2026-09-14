# GitHub Actions authentication with Azure OIDC

This repository is designed to authenticate GitHub Actions to Azure without storing a client secret.

## High-level setup

1. Create a Microsoft Entra application / service principal.
2. Assign only the Azure role(s) required for the target subscription or resource group.
3. Add a federated credential for this GitHub repository.
4. Add the client ID, tenant ID and subscription ID as GitHub repository variables.

Example federated subject for the `main` branch:

```text
repo:ispartaliemir32/azure-enterprise-platform:ref:refs/heads/main
```

For pull requests, create an additional federated credential if you want authenticated plans from PR workflows.

## GitHub variables

```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
```

The workflow requests `id-token: write` only where Azure login is required.
