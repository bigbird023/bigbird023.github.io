(---
layout: default
title: CI Maturity and Gitflow Release Patterns
permalink: /knowledge/secdevops/cicd/ci-maturity-pattern/
---

# CI Maturity tied to Gitflow (practical guide)

This note captures a practical approach for applying CI maturity stages to a Gitflow branching model. It is intended as a thought-driver and a short runbook you can adapt for teams that follow feature/develop/release/hotfix/main flows.

## Goals
- Map CI validation stages to Gitflow branches.
- Define artifact promotion and hand-off rules (promote, don't rebuild).
- Show triggers and example pipeline sketches (GitHub Actions flavored).
- Provide a short checklist and operational guidance for release managers.

## Gitflow recap (branches and intent)
- `feature/*` — developer work, short-lived, merged into `develop`.
- `develop` — integration branch for the next release.
- `release/*` — created from `develop` when preparing a release candidate.
- `hotfix/*` — fix production issues; branch from `main`, merge to `main` and `develop`.
- `main` — production branch; tags here are production releases.

## CI maturity levels (applied to branches)
- Level 1 — Fast feedback: build + unit tests + linters. Run on `feature/*` and `develop` PRs.
- Level 2 — Integration & security: integration tests, SAST, dependency scanning. Run on `develop` and `release/*`.
- Level 3 — Artifact publication & provenance: produce immutable artifacts with SBOM/signatures; publish to registry with metadata. Run on `release/*` and optionally `develop` for internal testing.
- Level 4 — CD separation & safe deploys: CD pipelines consume published artifacts, enforce approvals, and perform canary/rollouts. Triggered by tags, registry events, or manual promotions.

## Pragmatic mapping: branch → pipeline behavior
- feature/*
	- Run L1 only (fast).
	- Optional ephemeral build for preview environments (if PR preview infra exists).
	- DO NOT publish artifacts to central registries.

- develop
	- Run L1 + L2 (longer checks).
	- Publish internal/dev artifacts using ephemeral tags (e.g., `dev-<sha>`).
	- Use these artifacts for integration testing in dev environments.

- release/*
	- Run L2 + L3. Produce release-candidate (RC) artifacts with metadata (git sha, pipeline id, SBOM).
	- Preserve each RC as immutable (push as image digest or rc tag `rc/v1.2.0+<sha>`).
	- Allow small fixes on the release branch; each CI run produces a new RC artifact.

- main (on merge + tag)
	- When `release/*` is merged to `main` and tagged (e.g., `v1.2.0`), CD must deploy the exact RC artifact identified by digest.
	- CD should not rebuild the artifact from source — use the artifact produced by the release pipeline.

- hotfix/*
	- Similar to a release flow but focused: build, test, publish hotfix artifact, merge to `main` and `develop`, and trigger CD after approval.

## Artifact promotion & hand-off rules
- Artifact is the source of truth — record digest, SBOM, build metadata (git sha, pipeline id, builder image, timestamps).
- Promotion events (choose one or more):
	- Registry push webhook (artifact published) triggers downstream CD.
	- Repository tag push (vX.Y.Z) triggers CD that looks up artifact metadata created during RC.
	- repository_dispatch or pipeline trigger to start CD with explicit artifact reference.
	- Manual approval/Release dashboard action triggers promotion.
- Always pin the deployment to digest or an exact version; never use mutable tags for production deploys.

## Example GitHub Actions sketches (conceptual)

1) .github/workflows/ci.yml (build & test, dev artifacts)

```yaml
name: CI
on:
	push:
		branches:
			- 'feature/*'
			- develop

jobs:
	build:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v4
			- name: Build
				run: ./gradlew assemble
			- name: Unit tests
				run: ./gradlew test
			- name: Publish dev artifact
				if: startsWith(github.ref, 'refs/heads/develop')
				run: |
					# build image and push with tag dev-<sha>
					echo "publish dev artifact"
``` 

2) .github/workflows/release-candidate.yml (RC build & publish)

```yaml
name: Release Candidate
on:
	push:
		branches:
			- 'release/*'

jobs:
	rc-build:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v4
			- name: Build & Scans
				run: |
					./gradlew clean build
					./scripts/run-sast.sh
			- name: Publish RC image
				run: |
					# tag image rc/v1.2.0+<sha> and push
					echo "publish rc artifact with metadata"
			- name: Upload build metadata
				uses: actions/upload-artifact@v4
				with:
					name: build-metadata
					path: metadata.json
```

3) .github/workflows/deploy.yml (tag or registry-triggered)

```yaml
name: Deploy
on:
	push:
		tags:
			- 'v*'
# or use a repository_dispatch or registry webhook event

jobs:
	deploy:
		runs-on: ubuntu-latest
		steps:
			- name: Lookup artifact
				run: |
					# query artifact metadata store to find digest for the tag
					echo "lookup digest"
			- name: Deploy to prod
				run: |
					# deploy by digest
					echo "deploy artifact by digest"
```

These are sketches — we can expand into runnable workflows adapted to your build system and registry.

## Operational checklist for release managers
- Verify RC artifacts exist and SBOMs/provenance are attached.
- Confirm CVE/DAST/SAST gates are green or have accepted exceptions.
- Verify release notes & stakeholder approvals are recorded in the release ticket.
- Promote RC to final tag (vX.Y.Z) which triggers CD.
- Monitor deployment metrics and have rollback procedures at hand.

## Edge cases and notes
- Mono-repo: prefer per-service pipelines and artifact scoping to avoid building everything unnecessarily.
- Rebuilds vs promote: if your build is fully hermetic and reproducible, rebuilding could work; otherwise prefer promotion to preserve provenance.
- Short-lived hotfixes: allow expedited approval flows but require post-deploy audit and follow-up merge to `develop`.

## Next steps I can implement for you
- Draft runnable GitHub Actions workflows (ci.yml, release-candidate.yml, deploy.yml) tailored to your repo and registry.
- Add a PlantUML diagram that visualizes the Gitflow → RC → registry → CD flow and commit it to `/assets/img/`.
- Create a short release runbook template (CHECKLIST.md) that release managers can follow.

If you'd like I can add the workflows and a diagram now — which of the three next steps above should I do first?

