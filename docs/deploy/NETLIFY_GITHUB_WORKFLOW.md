# OTM-portfolio GitHub & Netlify Workflow

Project name: `OTM-portfolio`

GitHub: `https://github.com/Tyrrellkdlemons/OTM-portfolio`

Netlify production URL: `https://otm-portfolio.netlify.app`

Netlify admin URL: `https://app.netlify.com/projects/otm-portfolio`

## Local source

This folder is the deployable site root:

```text
otm-portfolio/
├── index.html
├── netlify.toml
├── site.webmanifest
├── assets/
│   ├── brand/
│   ├── css/portfolio.css
│   └── js/portfolio.js
├── scripts/
├── docs/deploy/
└── .github/workflows/netlify-deploy.yml
```

## First-time GitHub setup

```bash
cd otm-portfolio
git init && git branch -M main
git remote add origin https://github.com/Tyrrellkdlemons/OTM-portfolio.git
git add . && git commit -m "Initial portfolio"
git push -u origin main
```

If the repo doesn't exist yet, create it on GitHub first (Public, no README/license — we already have them).

## First-time Netlify setup

```bash
netlify login                      # browser-based
netlify sites:create --name otm-portfolio
netlify link --name otm-portfolio
netlify deploy --prod --dir=.
```

## Recurring deploy paths

1. **One-click (Windows):** `scripts/03-deploy-netlify.bat`
2. **Git auto-deploy:** push to `main`. Add these secrets to the repo for Actions deploys:
   - `NETLIFY_AUTH_TOKEN`
   - `NETLIFY_SITE_ID`
3. **Manual drag-and-drop:** zip the folder and drop on https://app.netlify.com/drop

## Why a separate repo

The main `OTM-workshops` site (https://otm-workshops.netlify.app) keeps its own lifecycle. This portfolio updates independently when new client sites ship, so it should not share a deploy with the main site.
