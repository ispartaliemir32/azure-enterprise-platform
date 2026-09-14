#!/usr/bin/env bash
set -euo pipefail

terraform fmt -check -recursive .

for env in dev prod; do
  echo "Validating $env"
  terraform -chdir="envs/$env" init -backend=false
  terraform -chdir="envs/$env" validate
done
