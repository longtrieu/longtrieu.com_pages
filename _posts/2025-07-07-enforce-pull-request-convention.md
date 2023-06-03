---
layout: post
layout: post
title: "Enforce Pull Request convention"
date: 2025-07-07
author: Long Trieu
description: We can make the world better
permalink: /enforce-pull-request-convention
---

If you work in a new team of developers, and each of them follow a different way of naming convention for commits and pull requests, you may have a hard time making sure your Git history is easy to manage. Git commits may not have same title format, some issues may link to a ticket while some don't.

Therefore, if you enforce the same way of naming convention for your commits and pull requests, everyone can follow and build a decent Git history.

There're a few things you may do:

### 1. Handle Pull Request title and body

- Let create a simple workflow to check the title and body of the Pull Request `.github/workflows/conventional-commits.yml` under your repository. Then in the same workflow, we will check all commits within the same Pull Request and apply the same logic

- For your reference, I'm following the convention here [Convention Commits](https://www.conventionalcommits.org/en/v1.0.0/) as an example. Details can be find here:

| Type       | Description                                                   |
|------------|---------------------------------------------------------------|
| feat       | A new feature                                                 |
| fix        | A bug fix                                                     |
| chore      | Routine tasks, maintenance, or changes that don't affect users|
| docs       | Documentation only changes                                    |
| style      | Code style changes (formatting, missing semicolons, etc.)     |
| refactor   | Code changes that neither fix a bug nor add a feature         |
| perf       | Performance improvements                                      |
| test       | Adding or updating tests                                      |
| build      | Changes affecting the build system or external dependencies   |
| ci         | Changes to CI/CD configuration files and scripts              |
| revert     | Reverts a previous commit                                     |

- You can find the workflow scripts here:

``` yaml
name: PR & Commit Convention Check

on:
  pull_request:
    types: [opened, edited, synchronize, reopened]

jobs:
  check-conventions:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Check PR Title and Description
        env:
          PR_TITLE: ${{ github.event.pull_request.title }}
          PR_BODY: ${{ github.event.pull_request.body }}
        run: |
          echo "Checking PR Title..."
          if [[ ! "$PR_TITLE" =~ ^(feat|fix|docs|style|refactor|perf|test|chore)(\([a-zA-Z0-9_-]+\))?:\ .+ ]]; then
            echo "PR title does not follow Conventional Commits format."
            echo "Example: 'feat(auth): add login feature'"
            exit 1
          fi

          echo "Checking PR Description for task URL..."
          if [[ ! "$PR_BODY" =~ https://github\.com/longtrieu/stories/issues/[0-9]+ ]]; then
            echo "PR description must include a task URL like:"
            echo "https://github.com/longtrieu/stories/issues/<issue-number>"
            exit 1
          fi

          echo "PR title and description passed checks."

      - name: Check Commit Messages
        run: |
          echo "Checking commit messages..."

          # Fetch both the base and head branches
          git fetch origin ${{ github.event.pull_request.base.ref }}
          git fetch origin ${{ github.event.pull_request.head.ref }}

          # Get commits excluding merge commits
          COMMITS=$(git log origin/${{ github.event.pull_request.base.ref }}..origin/${{ github.event.pull_request.head.ref }} --no-merges --pretty=format:"%H")

          if [[ -z "$COMMITS" ]]; then
            echo "No non-merge commits found in range."
            exit 0
          fi

          for COMMIT in $COMMITS; do
            TITLE=$(git log -1 --pretty=format:"%s" $COMMIT)
            BODY=$(git log -1 --pretty=format:"%b" $COMMIT)

            echo "Checking commit $COMMIT: '$TITLE'"

            # Skip merge commits
            if [[ "$TITLE" =~ ^Merge\ .+ ]]; then
              echo "Skipping merge commit: $TITLE"
              continue
            fi

            if [[ ! "$TITLE" =~ ^(feat|fix|docs|style|refactor|perf|test|chore)(\([a-zA-Z0-9_-]+\))?:\ .+ ]]; then
              echo "Commit title does not follow Conventional Commits format"
              echo "Offending title: '$TITLE'"
              echo "Expected format: 'feat(auth): add login feature'"
              exit 1
            fi

            if [[ ! "$BODY" =~ https://github\.com/longtrieu/stories/issues/[0-9]+ ]]; then
              echo "Commit body must include a task URL like:"
              echo "https://github.com/longtrieu/stories/issues/<issue-number>"
              exit 1
            fi
          done

          echo "All commit messages passed checks."
```

- Publish it by committing to GitHub

### 2. Handle Pull Request title and body

- Let create another simple workflow to check the title of the Pull Request `.github/workflows/auto-delete-branch.yml` under your repository

- The goal of this step is to make sure when your Pull Request is good to go and be merged, the topic branch will be deleted to clean up your working environment

- Please check it here:


``` yaml
name: Auto Delete Branch

on:
  pull_request:
    types: [closed]

jobs:
  delete-branch:
    # Only run if the PR was merged (not just closed)
    if: github.event.pull_request.merged == true
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Delete branch
        run: |
          echo "Attempting to delete branch ${{ github.event.pull_request.head.ref }}"

          # Capture both stdout and stderr, and get the exit code
          if output=$(git push origin --delete ${{ github.event.pull_request.head.ref }} 2>&1); then
            echo "Branch ${{ github.event.pull_request.head.ref }} deleted successfully"
          else
            exit_code=$?
            # Check if the error is specifically about the ref not existing
            if echo "$output" | grep -q "remote ref does not exist\|remote ref not found"; then
              echo "Branch ${{ github.event.pull_request.head.ref }} was already deleted or doesn't exist"
            else
              echo "Error deleting branch ${{ github.event.pull_request.head.ref }}:"
              echo "$output"
              exit $exit_code
            fi
          fi
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

- Publish it by committing to GitHub

### 3. Configure your GitHub repository to make sure the check have value on run time

Please access your repository' settings and turn this on:

- Navigate to **Settings**
- Open **Branches**
- Click *Add classic branch protection rule*
- Choose branch `master` or `main`, up to your setup
- Tick *Require status checks to pass before merging* and then *Require branches to be up to date before merging*
- Now fill in with **check-conventions**
- Scroll all the way down to the bottom and click **Create**

Now, at least you have some checks by a reliable companion to cover your back! Let's rock it!
