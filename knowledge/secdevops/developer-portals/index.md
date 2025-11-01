---
layout: page
title: Developer Portals
permalink: /knowledge/secdevops/developer-portals/
---

# Developer Portals — comparison and guidance

Developer portals (also called service catalogs or internal developer platforms) centralize developer onboarding, service metadata, standards, and operational controls. They reduce cognitive load, improve discoverability, and make it easier to run secure, compliant systems at scale.

This guide compares five popular tools: Backstage (open source by Spotify), OpsLevel, Atlassian Compass, Cortex, and Port. For each tool you'll find a short description, typical use cases, key strengths, integration notes, and recommended metrics to track.

## Backstage (diagrams, plugins, open-source)

- Summary: Backstage is an open-source developer portal from Spotify. It provides a plugin-based architecture, a software catalog, and templates to scaffold new services. It's highly extensible and widely adopted.
- Typical use cases: self-service scaffolding, software catalog, docs hub, API explorer, custom plugins for ownership and compliance.
- Strengths:
  - Open source and widely extensible via plugins
  - Strong community and ecosystem (many plugins and templates)
  - Good for organizations that want to own and customize their portal
- Integration notes:
  - Integrates with GitHub/GitLab, CI/CD, Kubernetes, ArgoCD, Vault, SSO providers
  - Plugins can ingest metadata from code (annotations), CI systems, and cloud accounts
- Recommended metrics:
  - Number of services registered
  - Time-to-create (scaffold) new services
  - % of services with ownership metadata, runbooks, and SLOs attached

## OpsLevel

- Summary: OpsLevel is a commercial service catalog and operational governance product focused on service-level ownership, reliability, and compliance.
- Typical use cases: compliance gating, maturity scoring, visibility into service reliability and ownership.
- Strengths:
  - Opinionated maturity model and scoring system out of the box
  - Good UI for SRE/ops maturity and owner workflows
  - Managed SaaS reduces operational overhead compared to self-hosting
- Integration notes:
  - Integrates with monitoring (Datadog, Prometheus), CI/CD, repos, cloud providers, and incident systems
  - Provides APIs and webhooks to automate scoring updates
- Recommended metrics:
  - Mean time to acknowledge/resolve incidents
  - % services passing maturity gates
  - Number of services with production SLOs and alerting configured

## Atlassian Compass

- Summary: Compass is Atlassian's developer portal and service catalog that integrates tightly with Jira, Confluence, Bitbucket, and the Atlassian product suite.
- Typical use cases: organizations already invested in Atlassian for project tracking who want a catalog with close Jira/Confluence integration.
- Strengths:
  - Tight integration with Jira/Confluence and Atlassian ecosystem
  - Useful for linking product context, tickets, and documentation to services
  - Good governance features when used with Atlassian access controls
- Integration notes:
  - Best when your toolchain already uses Atlassian products
  - Connectors exist for repos, CI/CD, and cloud providers; plugin model for extensions
- Recommended metrics:
  - Fraction of services linked to Jira projects and documentation
  - Number of service-level issues and average age
  - Adoption rate across teams (how many teams use Compass catalog)

## Cortex

- Summary: Cortex (by Meta? or other vendors — clarify vendor) — NOTE: "Cortex" can mean multiple projects; in the developer portal context, some vendors or internal teams have used the name for internal developer platforms. Confirm which Cortex you mean; below is a generic profile for Cortex-like platforms.
- Typical use cases: opinionated internal developer platforms that provide runbooks, service metadata, and automation.
- Strengths:
  - Often opinionated and pre-integrated for specific stacks
  - Focused on operational reliability and runbook automation
- Integration notes:
  - Check vendor-specific docs for connectors; many Cortex-like platforms integrate with monitoring, incident, and CI/CD tools
- Recommended metrics:
  - Runbook coverage (% services with an up-to-date runbook)
  - Automation-run success rates for common remediation tasks

## Port

- Summary: Port is a commercial internal developer portal that focuses on service discovery, ownership, and metadata; it offers an approachable UI and managed hosting.
- Typical use cases: teams that want a low-friction, managed portal with discovery and ownership features.
- Strengths:
  - Fast to get started with a hosted option
  - Simple UX for non-platform-engineer teams
- Integration notes:
  - Integrates with git providers and supports metadata ingestion, service pages, and basic integrations to alerting/monitoring
- Recommended metrics:
  - Time to onboard a service into the portal
  - Number of manual lookups vs portal lookups (adoption)

## Choosing the right tool — decision criteria

- Scale & control: Do you prefer open-source self-hosted (Backstage) for full control and customization, or SaaS (OpsLevel, Port) for lower operational overhead?
- Toolchain fit: If you already use Atlassian heavily, Compass provides tight integration; if you need strong SRE maturity scoring, OpsLevel may be a better fit.
- Customization needs: Backstage shines when you need custom plugins and deep integration with internal workflows.
- Time-to-value: SaaS products often provide quicker onboarding and pre-built scoring and governance.

## DAR Evaluation for Adoption

 - [DAR Evaluation](/knowledge/evaluation/DAR) is a tool that can help drive a decision for which tool to pick