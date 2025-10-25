---
layout: default
title: CI/CD Pattern — Separate CI and CD with a Trigger
permalink: git pus
---

# CI/CD Pattern: Keep CI and CD separate, bridge with triggers

<img class="pattern-img" src="/assets/img/CICD-pattern.svg" alt="CI/CD pattern" />

A recommended pattern is to separate Continuous Integration (CI) from Continuous Delivery/Deployment (CD) and use an explicit "trigger" as the hand-off. This makes pipelines more auditable, simplifies security boundaries, and enables flexible promotion workflows across environments.

## Roles: CI vs CD

- CI (Continuous Integration): build, unit/integration tests, static analysis, package/artifact creation. CI must be fast, repeatable, and produce an immutable artifact.
- CD (Continuous Delivery/Deployment): consumes artifacts and performs environment-specific deployments (staging, canary, production), rollout strategies, DB migrations, and smoke tests. CD engines focus on deployment safety and observability.

## Why separate them?

- Security boundary: CI often runs many untrusted PRs; CD runs under stricter controls with approvals and limited credentials.
- Immutable artifacts: CI produces artifacts (container images, packages) that are promoted; CD should deploy those immutable artifacts rather than rebuilding.
- Clear audit trail: separation makes it obvious which artifact version was deployed and when.
- Flexible promotion: different triggers can promote artifacts to environments without rerunning full CI.

## Trigger types (the hand-off)

- Artifact publish: CI pushes a new image/package to a registry (e.g., Docker registry, Maven/NPM) and the push event triggers CD.
- Release/tag: CI or release manager creates a semantically-versioned tag or GitHub/GitLab Release which triggers CD to pick up the tagged artifact.
- Manual approval / Release management: a human approves a promotion (in a release dashboard) which triggers CD.
- Scheduled/promotional: scheduled promotion (nightly, weekend) or business-driven releases.
- Webhook/event: custom events from release systems, ticketing (e.g., Jira transition), or external signals.

## Implementation patterns across platforms

- GitHub Actions: CI workflow builds and publishes image -> image push triggers a separate deployment workflow (via repository_dispatch, image registry webhook, or release tag).
- GitLab CI: use separate pipelines (or multi-project pipelines) and triggers; CI pushes artifact to registry and triggers downstream CD pipeline.
- Jenkins: separate declarative pipelines or freestyle jobs; CI job publishes and triggers the CD job via webhook or Jenkins build trigger.
- Azure DevOps: use Pipelines for CI to publish artifacts to Azure Artifacts or ACR; use Release pipelines or separate YAML CD pipelines triggered by artifact versions.
- Bitbucket Pipelines: publish artifacts and use deployment variables and pipelines; connect with Jira for release-based triggers.

## Best practices

- Artifact immutability: always deploy images/artifacts identified by digest or exact version — never by "latest".
- Signed artifacts and provenance: produce SBOMs, sign artifacts, and record build metadata for traceability.
- Promote, don't rebuild: CD should deploy artifacts produced by CI to avoid drift.
- Keep secrets out of CI logs and use vault/secrets-manager for CD credentials.
- Implement gating: require SAST/DAST, test coverage thresholds, and SLO checks before promotion to production.
- Use feature flags for risky changes and Canary deployments for safety.
- Implement automated rollbacks and health checks in CD pipelines.
- Record audit logs for all promotion events and approvals.

## Example workflow

<img class="pattern-img" src="/assets/img/CICD-pattern.svg" alt="CI/CD pattern" />

1. Developer commits to a repository
2. CI Triggered on Commit
3. CI Pattern executes with artifact generation and storage
4. triggering event for CD
5. CD Pattern executes with evironment deployment and changes are live

## When triggers vary

- For internal library artifacts you may rely on semantic versioning and release tags as the trigger.
- For hotfixes you may prefer manual release management to control the cadence.
- For continuous deployment teams you may chain artifact push -> automated CD with immediate rollout after passing tests.

## Security considerations

- Least privilege: CD runners/agents should have minimal privileges and use ephemeral credentials where possible.
- Separate secrets stores: CD should access production credentials from hardened secret stores (Vault, AWS Secrets Manager).
- Approval policies: enforce approvals for production promotions, and optionally for deployments to high-sensitivity environments.

## Observability & metrics

Track these KPIs:
- Build-to-deploy time (CI completion to successful production deploy)
- Deployment frequency and lead time for changes
- Mean time to rollback/restoration
- % of deployments using canary or feature-flag rollouts
- Audit trail completeness (are artifact provenance and approvals recorded?)

## Conclusion

Separating CI and CD with a clear trigger provides security, traceability, and deployment flexibility. Use immutable artifacts, enforce gating and approvals, and automate health checks to get fast and safe promotions.
