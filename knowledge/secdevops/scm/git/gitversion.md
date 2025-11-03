---
layout: page
title: CI/CD Pattern — Separate CI and CD with a Trigger
permalink: /knowledge/secdevops/scm/git/gitversion
---

# GitVersion: Semantic Versioning for CI/CD Pipelines

[GitVersion](https://github.com/GitTools/GitVersion) automates semantic versioning for Git-based projects. It analyzes your repository's branching and commit history to generate version numbers that reflect your workflow, making it ideal for CI/CD pipelines where traceable, immutable versions are required.

## Why Use GitVersion in CI/CD?

- **Automated versioning:** Every build and release gets a unique, traceable version.
- **Traceability:** Connects deployed artifacts to specific commits, branches, and tags.
- **Consistency:** Enforces semantic versioning and reduces manual errors.
- **Integration:** Compatible with major CI/CD platforms (GitHub Actions, Azure DevOps, GitLab CI, Jenkins, etc.).

## How GitVersion Works

- Analyzes your Git repository (branches, tags, commits).
- Applies a versioning strategy (e.g., GitFlow, mainline, custom).
- Outputs a semantic version (e.g., `1.2.3-beta.4+5`) for packaging, tagging, and deployment.

## Typical CI/CD Workflow with GitVersion

1. **Commit or PR is pushed** to the repository.
2. **CI pipeline runs GitVersion** to calculate the build version.
3. **Artifacts are built and tagged** with the calculated version (e.g., Docker images, NuGet packages).
4. **CD pipeline deploys** the artifact, referencing the exact version produced by CI.

## Example: Using GitVersion in a CI Pipeline

```yaml
# GitHub Actions example
- name: Install GitVersion
	uses: GitTools/actions/gitversion/setup@v0.9.18

- name: Run GitVersion
	id: gitversion
	uses: GitTools/actions/gitversion/execute@v0.9.18

- name: Use version
	run: echo "Version: ${{ steps.gitversion.outputs.fullSemVer }}"
```

## Best Practices

- Use GitVersion to generate immutable, traceable versions for all CI artifacts.
- Store the calculated version in build metadata and use it for deployment tags.
- Integrate GitVersion early in your pipeline to ensure all steps use the same version.
- Reference [GitVersion documentation](https://gitversion.net/docs/) for advanced configuration and branching strategies.

## Resources

- [GitVersion GitHub Repository](https://github.com/GitTools/GitVersion)
- [GitVersion Documentation](https://gitversion.net/docs/)

## Notes

### Docker Running Command

```
docker run --rm -v "$(pwd):/repo" gittools/gitversion:5.10.0 /repo /b releases/1.2.0
```

### Tag prefixes

RegExp:

- tag-prefix: '(tags-alpha/v|tags-beta/v|tags-rc/v|tags-hotfix/v|[v])'

Description

- Alpha versions: For libraries in active development (in the develop branch).
- Beta versions: For libraries that are feature-complete but may still need testing (in the release branch).
- RC (Release Candidate) versions: For libraries nearing a stable release, with minimal changes expected (in the release branch).
- Production versions: Stable, production-ready libraries (on the master branch), without a suffix.