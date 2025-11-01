---
layout: page
title: CI/CD Pattern — Separate CI and CD with a Trigger
permalink: /knowledge/secdevops/cicd/cicd-pattern
---

# CI/CD Pattern: Keep CI and CD separate, bridge with triggers

<img class="diagram-img" src="/assets/img/CICD-pattern.svg" alt="CI/CD pattern" />

A recommended pattern is to separate Continuous Integration (CI) from Continuous Delivery/Deployment (CD) and use an explicit "trigger(s)" as the hand-off. This makes pipelines more auditable, simplifies security boundaries, and enables flexible promotion workflows across environments.

## Roles: CI vs CD

- CI (Continuous Integration): build, unit/integration tests, static analysis, package/artifact creation. CI must be fast, repeatable, and produce an immutable artifact.
- CD (Continuous Delivery/Deployment): consumes artifacts and performs environment-specific deployments (staging, canary, production), rollout strategies, DB migrations, and smoke tests. CD engines focus on deployment safety and observability.

## Why separate them?

- Security boundary: CI often runs many untrusted PRs; CD runs under stricter controls with approvals and limited credentials.
- Immutable artifacts: CI produces artifacts (container images, packages) that are promoted; CD should deploy those immutable artifacts rather than rebuilding.
- Clear audit trail: separation makes it obvious which artifact version was deployed and when.
- Flexible promotion: different triggers can promote artifacts to environments without rerunning full CI.

## Trigger types (the hand-off)

Different trigger types exist to hand-off CI into CD. 

Single Artifact Deployments:
- Artifact publish: CI pushes a new image/package to a registry (e.g., Docker registry, Maven/NPM) and the push event triggers CD.
- Release/tag: CI or release manager creates a semantically-versioned tag or GitHub/GitLab Release which triggers CD to pick up the tagged artifact.
- Manual approval / Release management: a human approves a promotion (in a release dashboard) which triggers CD.
- Scheduled/promotional: scheduled promotion (nightly, weekend) or business-driven releases.
- Webhook/event: custom events from release systems, ticketing (e.g., Jira transition), or external signals.

Multiple Artifact / GitOps Deployments (expected state):
- GitOps repository commit
- Manual approval / Release management: a human approves a promotion (in a release dashboard) which triggers CD.
- Scheduled/promotional: scheduled promotion (nightly, weekend) or business-driven releases.

## Implementation patterns across platforms

[CICD Tools](/knowledge/secdevops/cicd/tools)

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

1. Developer commits to a repository
2. CI Triggered on Commit
3. CI Pattern executes with artifact generation and storage
4. triggering event for CD
5. CD Pattern executes with evironment deployment and changes are live

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
