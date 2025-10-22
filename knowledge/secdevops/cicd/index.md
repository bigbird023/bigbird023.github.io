---
layout: default
title: CI/CD & Automation
permalink: /knowledge/secdevops/cicd/
---

# CI/CD & Automation — overview and comparison

This page compares common CI/CD platforms and automation approaches, highlights their benefits, and offers guidance for choosing and measuring a CI/CD solution.

Tools covered: Jenkins, Azure DevOps (Pipelines), GitLab CI, GitHub Actions, Bitbucket (Pipelines), Projen pipelines, plus recommended additions (Tekton, ArgoCD).

## Jenkins

- Summary: Jenkins is a mature, highly extensible open-source automation server with a huge plugin ecosystem. It's ideal when you need deep customization and full control.
- Benefits:
  - Extremely flexible and scriptable
  - Large plugin ecosystem for integrations
  - Works with any SCM, cloud provider, and deployment target
- Considerations:
  - Requires operational overhead to run at scale (manage masters/agents, upgrades, plugin compatibility)
  - UI and developer ergonomics are less modern than cloud-native alternatives
- Best for: organizations that need extreme customization or have long-standing Jenkins investments.

## Azure DevOps (Pipelines)

- Summary: Azure DevOps provides a fully-managed CI/CD platform with deep integration into Azure and the Microsoft ecosystem.
- Benefits:
  - Native integration with Azure services, Boards, and Repos
  - Hosted agents and cloud scalability
  - YAML pipelines support multi-stage pipelines and environments
- Considerations:
  - Best value when your org uses Azure or Microsoft tools heavily
  - Some advanced scenarios may still require custom agents or extensions
- Best for: teams using Azure cloud and Atlassian alternatives in the Microsoft stack.

## GitLab CI

- Summary: GitLab CI is an integrated CI/CD solution inside GitLab that provides pipelines, container registry, and built-in security scanning (with premium tiers).
- Benefits:
  - Tight integration with repos, issues, and merge requests
  - Auto DevOps and templates to get started quickly
  - Good if you want a single platform for SCM+CI/CD
- Considerations:
  - Self-managed GitLab requires operational expertise; SaaS GitLab reduces overhead
  - Some advanced features are in paid tiers
- Best for: teams wanting an all-in-one SCM + CI/CD experience with strong built-in features.

## GitHub Actions

- Summary: GitHub Actions provides native CI/CD within GitHub with a rich marketplace of actions and strong community support.
- Benefits:
  - Very easy to get started if your code is on GitHub
  - Marketplace actions accelerate common steps (setup, testing, deployment)
  - Good for monorepos and event-driven workflows
- Considerations:
  - Hosted runner minutes and concurrency have cost considerations for large CI loads
  - GitHub's event model can be extremely flexible but requires careful design to avoid sprawl
- Best for: teams using GitHub who want tight integration and minimal setup friction.

## Bitbucket (Atlassian)

- Summary: Bitbucket Pipelines is Atlassian's CI/CD offering integrated with Bitbucket Cloud (and can be paired with Bamboo or other runners for Bitbucket Server/Data Center). It provides YAML-based pipelines, Docker-native steps, and tight linkage to Bitbucket PRs.
- Benefits:
  - Native integration with Bitbucket repositories and PRs
  - Simple pipeline as code (bitbucket-pipelines.yml) and quick setup
  - Good Jira and Confluence integration through the Atlassian ecosystem
- Considerations:
  - Build minutes and concurrent runner limits apply on Bitbucket Cloud; large scale workloads may require self-hosted runners
  - Smaller action/step marketplace compared with GitHub Actions; for advanced orchestration teams often pair with Bamboo or external runners
  - Bitbucket Server/Data Center customers commonly use Bamboo for deeper enterprise features
- Best for: teams already invested in the Atlassian toolchain (Bitbucket + Jira) that want frictionless CI in the same platform.

## Projen pipelines (projen-pipelines)

- Summary: Projen is a project configuration tool that uses code to generate project scaffolding; projen-pipelines allows you to define CI/CD pipelines as code in the same way.
- Benefits:
  - Keep CI/CD definitions in code alongside project configuration
  - Reproducible, templatized pipelines across multi-repo setups
  - Great for standardizing pipelines across an organization
- Considerations:
  - Additional abstraction layer — requires maintainers familiar with Projen
  - Best paired with a CI runner (GitHub Actions, GitLab CI, or other)
- Best for: organizations that want a single source of truth for project and pipeline templates and consistent automation across repos.

## Recommended additions & patterns

- Tekton: A Kubernetes-native pipeline engine (useful if you want cloud-native, CRD-driven pipelines that run in-cluster).
- ArgoCD / Flux: GitOps continuous delivery tools focused on declarative deployment of Kubernetes resources. Use ArgoCD for automated, auditable deployments.
- Container registries & SBOM: Use a trusted registry (ECR/GCR/ACR/GitLab Container Registry) and produce SBOMs and image scans in your pipeline.

## How to choose

- Where your code lives: GitHub -> Actions; GitLab -> GitLab CI; Azure customers -> Azure Pipelines.
- Scale and complexity: Jenkins or Tekton when you need non-standard orchestration; managed SaaS for fast time-to-value.
- Compliance and governance: consider pipelines-as-code, artifact immutability, signed images, SBOMs, and immutable environments.

## Example metrics to track (CI/CD KPIs)

- Build success rate (per branch / per pipeline)
- Mean build time and median time-to-merge
- Time to restore service (if pipeline-related failures happen)
- Deployment frequency and lead time for changes
- Flaky test rate and test coverage trends

## DAR Evaluation for Adoption

 - [DAR Evaluation](/knowledge/evaluation/DAR) is a tool that can help drive a decision for which tool to pick