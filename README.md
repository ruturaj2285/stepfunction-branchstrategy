# Jaime-DataCollection (POC)

## What changes trigger deployments?
- Changes under `functions/**` → Lambda update
- Changes under `step-function-workflow/<env>/**` → Step Function update for that env

## Environments
- `develop/*` → `dev`
- `release/*` → `stg`
- `v*.*.*` tag → `prod`

## Naming convention (POC)
- Lambda: `<folder-name>-<env>` e.g., `report-job-dev`
- Step Function: `<folder-name>-<env>` e.g., `data-pipeline-dev`

## One-time setup
- Create Lambdas and Step Functions once (console/Terraform) with the names above.
- Configure GitHub OIDC → AWS role (for CI).
- Set `AWS_REGION` & `AWS_ACCOUNT_ID` in workflow env or repository secrets.

## Flow
1. Push changes to `develop/*`, `release/*`, or tag `vX.Y.Z`
2. Workflow detects changed folders and env
3. Only changed Lambdas/Step Functions are deployed
