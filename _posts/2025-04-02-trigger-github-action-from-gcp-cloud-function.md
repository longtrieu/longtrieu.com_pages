---
layout: post
title: "Trigger GitHub Action workflow from GCP Cloud Function"
date: 2025-04-02
author: Long Trieu
description: We can make the world better
permalink: /trigger-github-action-from-gcp-cloud-function
---

If you have a GitHub Action workflow that you want to run on scheduled, then you may realize that GitHub Action cron is unreliable and unstable. Reasons are:
- GitHub uses a best-effort scheduler — there’s no guarantee that the job starts exactly at the scheduled time.
- Jobs may be delayed if:
   - The GitHub Actions runner is under high load
   - The repo is on a free plan or not prioritized in the queue
- It can even skip scheduled runs if:
   - There hasn’t been a recent push to the default branch
   - The repository is inactive (no events or pushes in >60 days)
   - There’s a workflow configuration error (e.g., invalid cron, permissions)

Therefore, instead of relying on GitHub Action cron, GCP Cloud Function and Scheduler Job might be your next best friend

### 1. Setup your basic GitHub Action workflow

- Let create a simple workflow to generate a Standup Issue on GitHub, save it under `.github/workflows/daily-standup.yml` within repository `/standup` for example

``` bash
name: Daily Standup Issue

on:
  workflow_dispatch:  # Only runs when triggered manually or via API

jobs:
  create-standup:
    runs-on: ubuntu-latest

    steps:
      - name: Get Today
        id: date
        run: |
          echo "today=$(date +'%Y/%m/%d')" >> $GITHUB_OUTPUT

      - name: Create Standup Issue
        id: create_issue
        uses: actions-ecosystem/action-create-issue@v1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          title: "Daily Standup - ${{ steps.date.outputs.today }}"
          body: |
            ## Standup Notes - ${{ steps.date.outputs.today }}

            Please reply with a comment below with this format:

            **YESTERDAY**: What did you work on yesterday?
            **TODAY**: What will you work on today?
            **BLOCKERS**: Any blockers?
          labels: standup # Need to create a label `standup` or you can remove this
          assignees: ${{ github.actor }} # Assign it to yourself because why not
```

- Publish it by committing to GitHub

### 2. Generate GitHub Personal Access Token (PAT)

To get GitHub Personal Access Token (PAT) so you can trigger workflows or interact with the GitHub API, follow these steps:
- Go to Token Settings
   - Visit: [https://github.com/settings/tokens](https://github.com/settings/tokens)
   - Click "Tokens (classic)" → then click "Generate new token (classic)"
- Choose Token Scopes (Permissions)
   - Minimum required scopes: `repo` + `workflow`
- Set Expiration and Description
- Generate and Save the Token
   - It may look like `ghp_XXXXXXX....`

### 3. Create a Cloud Function on GCP

- You can create a new Google Cloud Function, and set it up like this:

``` bash
cloud-function/
├── index.js
├── package.json
```

``` js
index.js

const fetch = require('node-fetch');

exports.triggerWorkflow = async (req, res) => {
  const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
  const OWNER = 'your-username-or-org';
  const REPO = 'standup';
  const WORKFLOW_FILE = 'daily-standup.yml';
  const REF = 'main'; // or 'master', check it to make sure

  const url = `https://api.github.com/repos/${OWNER}/${REPO}/actions/workflows/${WORKFLOW_FILE}/dispatches`;

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${GITHUB_TOKEN}`,
      'Accept': 'application/vnd.github+json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ ref: REF })
  });

  if (response.status === 204) {
    res.status(200).send('GitHub Action triggered successfully.');
  } else {
    const error = await response.text();
    res.status(500).send(`Failed to trigger GitHub Action:\n${error}`);
  }
};
```

``` json
package.json
{
  "name": "trigger-github-action",
  "version": "1.0.0",
  "main": "index.js",
  "dependencies": {
    "node-fetch": "^2.6.7"
  }
}
```

- Then you need to add the variable for `GITHUB_TOKEN`
   - Go to Google Cloud Console → Cloud Functions
	 - Click on your Function → Edit & deploy new revision
	 - Scroll to "Variables & Secrets" → Environment variables
   - Add: GITHUB_TOKEN `ghp_XXXXXXX....`
   - Your code can now access `process.env.GITHUB_TOKEN`

- Re-deploy your Function and grab the URL to the Function, it may look like this `https://{name}-69830429786.{region}.run.app`

### 4. Create a Scheduler Job

Go to [Google Cloud Scheduler](https://console.cloud.google.com/cloudscheduler) and Enable it (if you didn't already)

Create a new Job and fill in with:
- Name
- Frequency: * * * * * (cron format), you can always check it [here](https://www.ibm.com/docs/en/db2-as-a-service?topic=task-unix-cron-format)
- Timezone: your expected timezone
- Target: HTTP
- URL: Paste the Cloud Function trigger URL from previous step
- HTTP method: POST
- Body: {} or empty
- Header: `Content-Type`: `application/json`
Save your Job and it's Done

### 5. Extra section: Cost!

So, is it free?
- Cloud Function: for standup you just need	~22 calls per month, so it's $0 (free tier)
- Cloud Scheduler: you just need 1 job, so it's $0 (free tier, you have 3 jobs for free)

Enjoy the automatic reliable Workflow on GitHub Action!
