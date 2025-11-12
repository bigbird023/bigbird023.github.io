---
layout: page
title: Developer Portals
permalink: /knowledge/secdevops/scm/git/gitflow
---

# Gitflow Branching Model

Gitflow is a popular branching strategy for managing features, releases, and hotfixes in Git repositories. It provides a robust workflow for collaborative development and release management.

<img src="/assets/img/gitflow.png" alt="Gitflow diagram" style="max-width:1000px; width:100%; height:auto; display:block; margin:0 auto;" />

## Main Branches

### 1. `main` (or `master`)

- **Purpose:** The main production branch. Always contains the latest released code.
- **Usage:** Only updated via merges from `release` or `hotfix` branches.

### 2. `develop`

- **Purpose:** The integration branch for new features and ongoing development.
- **Usage:** All completed features are merged here. Serves as the base for `release` branches.

## Supporting Branches

### 7. `bugfix/*`

- **Purpose:** Used for fixing bugs found during release preparation.
- **Naming:** `bugfix/issue-description`
- **Created from:** `release/*`
- **Merged into:** `release/*` and optionally `develop`
- **Usage:** Addresses issues discovered in the `release/*` branch before final production release.

### 3. `feature/*`

- **Purpose:** Used for developing new features.
- **Naming:** `feature/feature-name`
- **Created from:** `develop`
- **Merged into:** `develop`

### 4. `release/*`

- **Purpose:** Prepares for a new production release.
- **Naming:** `release/x.y.z`
- **Created from:** `develop`
- **Merged into:** `main` and `develop`
- **Usage:** Bug fixes, documentation, and other release tasks.

### 5. `hotfix/*`

- **Purpose:** Quick fixes for production issues.
- **Naming:** `hotfix/x.y.z`
- **Created from:** `main`
- **Merged into:** `main` and `develop`
- **Usage:** Critical bug fixes that need immediate deployment.

### 6. `support/*` (optional)

- **Purpose:** Maintains older versions after major releases.
- **Naming:** `support/version`
- **Usage:** For long-term support of previous releases.

## Typical Workflow

1. **Feature Development:**
	- Create a `feature/` branch from `develop`.
	- Work on the feature, then merge back into `develop`.
2. **Release Preparation:**
	- Create a `release/` branch from `develop`.
	- Finalize release, then merge into `main` and `develop`.
3. **Bugfixes during Release:**
	- Create a `bugfix/` branch from the relevant `release/*` branch.
	- Fix the bug, then merge back into the same `release/*` branch (and optionally `develop`).
4. **Hotfixes:**
	- Create a `hotfix/` branch from `main`.
	- Apply fix, then merge into `main` and `develop`.

## Diagram

<div class="mermaid">
graph TD
	A(main) -->|hotfix| H(hotfix/x.y.z)
	D(develop) -->|feature| F(feature/*)
	D -->|release| R(release/x.y.0)
	F --> D
	R --> D
	R --> A
	H --> A
	A --> D
	R -->|bugfix| B(bugfix/*)
	B --> R
	B --> D
</div>

## Summary Table

| Branch Type   | Base       | Merges Into         | Purpose                       |
|--------------|------------|---------------------|-------------------------------|
| main         | release    | -                   | Production code               |
| develop      | feature    | release, hotfix     | Integration, next release     |
| feature/*    | develop    | develop             | New features                  |
| release/*    | develop    | main, develop       | Release preparation           |
| bugfix/*     | release/*  | release/*, develop  | Bug fixes during release      |
| hotfix/*     | main       | main, develop       | Urgent fixes                  |
| support/*    | main       | -                   | Long-term support             |

## References

- [Gitflow Workflow - Atlassian](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [Original Gitflow post by Vincent Driessen](https://nvie.com/posts/a-successful-git-branching-model/)
