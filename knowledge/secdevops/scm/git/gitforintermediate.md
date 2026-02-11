---
layout: page
title: Git for Intermediate
permalink: /knowledge/secdevops/scm/git/git-for-intermediate/
---

# Git for Beginners

This friendly guide helps you get productive with Git quickly. It covers the essential commands and workflows most teams use, plus how to recover from common mistakes.

## Quick Start (5 commands)

```bash
# 1) Configure once
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main

# 2) Get code
git clone https://github.com/your-org/your-repo.git

# 3) Make changes
git status          # see what's changed
git add .           # stage your edits
git commit -m "Meaningful summary"

# 4) Share your changes
git push            # sends commits to remote
```

---

## Installation

- Linux (Debian/Ubuntu):
	```bash
	sudo apt update && sudo apt install -y git
	```
- macOS:
	```bash
	brew install git
	```
- Windows: Install Git for Windows from git-scm.com and use Git Bash.

## First-Time Setup

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main     # default branch name
git config --global core.editor "code --wait"   # use VS Code for messages
```

Optionally add helpful aliases:
```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.st status
git config --global alias.ci "commit -m"
```

## Creating or Getting a Repo

- Start a new repo:
	```bash
	mkdir my-app && cd my-app
	git init
	echo "# My App" > README.md
	git add README.md
	git commit -m "Initial commit"
	```
- Clone an existing repo:
	```bash
	git clone https://github.com/your-org/your-repo.git
	cd your-repo
	```

## Tracking Changes

- See what changed:
	```bash
	git status
	git diff           # unstaged changes
	git diff --staged  # staged vs last commit
	```
- Stage and commit:
	```bash
	git add file1 file2   # or: git add .
	git commit -m "Describe what and why"
	```
- View history:
	```bash
	git log --oneline --graph --decorate --all
	```

### Ignore files

Create `.gitignore` to skip files you don’t want in the repo (build outputs, secrets, local configs):
```
node_modules/
.env
dist/
*.log
```

## Branching Basics

- List and create branches:
	```bash
	git branch           # list local branches
	git branch feature/login
	```
- Switch branches:
	```bash
	git switch feature/login   # preferred
	# or: git checkout feature/login
	```
- Merge your feature into `main`:
	```bash
	git switch main
	git merge feature/login    # resolves fast-forward or creates a merge commit
	```
- Delete a finished branch:
	```bash
	git branch -d feature/login         # safe delete (merged)
	git branch -D feature/login         # force delete
	```

For branching strategies and versioning conventions, see:

- Git Flow: [gitflow.md](gitflow.md)
- Semantic Versioning: [gitversion.md](gitversion.md)

## Working with Remotes

- Check remotes:
	```bash
	git remote -v
	```
- Add and push to `origin`:
	```bash
	git remote add origin https://github.com/your-org/your-repo.git
	git push -u origin main   # sets upstream; later just `git push`
	```
- Pull latest changes:
	```bash
	git pull          # merge (default)
	git pull --rebase # keep linear history
	```
- Fetch without merging:
	```bash
	git fetch
	```

## Typical Feature Workflow (PR based)

```bash
# Start from an up-to-date main
git switch main
git pull --rebase

# Create your feature branch
git switch -c feature/csv-import

# Work + commit in small, focused steps
git add .
git commit -m "Parse CSV rows into model"

# Sync your branch to remote
git push -u origin feature/csv-import

# Open a Pull Request in GitHub/GitLab; after review, merge
```

## Undo & Recovery

- Unstage a file:
	```bash
	git restore --staged path/to/file
	```
- Discard local changes:
	```bash
	git restore path/to/file          # careful: loses edits
	```
- Revert a commit (safe, new commit):
	```bash
	git revert <commit-sha>
	```
- Reset to a previous commit (changes working tree):
	```bash
	git reset --soft <sha>   # keep changes staged
	git reset --mixed <sha>  # default, keep changes unstaged
	git reset --hard <sha>   # loses local changes — use with caution
	```
- Stash work temporarily:
	```bash
	git stash
	git stash list
	git stash pop
	```

## Resolving Merge Conflicts

When Git can’t auto-merge, it marks conflicts inside files. Open them in your editor, keep the desired sections, and remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`). Then:

```bash
git add path/to/conflicted-file
git commit   # completes the merge
```

## Credentials & SSH Keys

- Generate an SSH key and add it to your Git host:
	```bash
	ssh-keygen -t ed25519 -C "you@example.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub   # copy into GitHub/GitLab settings
	```
- Use HTTPS with a Personal Access Token (PAT) when SSH isn’t allowed.

## Line Endings & Cross-Platform

Use `.gitattributes` to normalize line endings across Windows/macOS/Linux:

```
* text=auto
```

## Good Commit Messages

- Start with a short imperative summary (max ~72 chars).
- Explain the “why” and key changes in the body.
- Reference issues/tickets when applicable.

Examples:

```
fix(auth): handle token refresh on 401

Adds automatic retry with refresh to reduce user lockouts.
```

## Advanced (optional)

- Rebase a branch on latest `main`:
	```bash
	git switch feature/csv-import
	git fetch origin
	git rebase origin/main
	# fix conflicts, then: git rebase --continue
	```
- Keep linear history with squash merges in PRs.
- For GitOps practices, see: [gitops.md](gitops.md)

## Glossary

- Repository: A project tracked by Git.
- Commit: A snapshot of changes with a message.
- Branch: A movable pointer to commits; isolates work.
- Merge: Combine changes from one branch into another.
- Rebase: Replay commits onto a new base for linear history.
- Remote: A hosted copy of your repo (e.g., GitHub).

## Troubleshooting

- "Detached HEAD": You checked out a commit directly. Switch back to a branch: `git switch main`.
- "Diverged branches": Your local and remote both have different commits. Use `git pull --rebase` or reconcile manually.
- "Permission denied (publickey)": Ensure your SSH key is added and ssh-agent has it.

---

Want deeper dives on strategies and governance? Visit the Git section index: /knowledge/secdevops/scm/git/

