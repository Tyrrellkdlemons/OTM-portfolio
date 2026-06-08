# OTM Portfolio

Live showcase of monument sites built by **Out The Mud Work Shops**.

- **Live:** https://otm-portfolio.netlify.app (target — provision via Netlify)
- **Repo target:** https://github.com/Tyrrellkdlemons/OTM-portfolio
- **Sibling project:** https://otm-workshops.netlify.app (main OTM site, untouched)

## What this is

A standalone portfolio page that loads the four current monument sites in live `<iframe>` previews with a graceful "Open Site" fallback when a site blocks framing. Features:

- Minimal header — Home + Book Now only
- Big OTM logo at the top, framed bold hero
- Live iframe previews with X-Frame-Options detection + fallback
- **Theme Engine** switch — Classic / Terminal / Street / Editorial palettes
- **Layout** switch — Grid / List
- **Live Refresh** toggle — auto-reload previews every 60s
- Footer with full company info including DUNS placeholder
- Konami code easter egg

## Structure

```text
otm-portfolio/
├── index.html
├── netlify.toml
├── site.webmanifest
├── robots.txt
├── sitemap.xml
├── assets/
│   ├── brand/  (favicon.svg, otm-logo.png, otm-logo-mark.png)
│   ├── css/portfolio.css
│   └── js/portfolio.js
├── scripts/        (Windows one-click .bat helpers — blocked from public)
├── .github/workflows/netlify-deploy.yml
└── docs/deploy/NETLIFY_GITHUB_WORKFLOW.md
```

## Local dev

```bash
python -m http.server 8080
# open http://localhost:8080
```

Or use the `scripts/04-dev-server.bat` one-click.

## Deploy

This project is independent of the main `OTM-workshops` repo. New GitHub + Netlify pair.

### First-time

```bash
# inside otm-portfolio/
git init && git branch -M main
git remote add origin https://github.com/Tyrrellkdlemons/OTM-portfolio.git
git add . && git commit -m "Initial portfolio"
git push -u origin main

# Netlify
netlify sites:create --name otm-portfolio
netlify deploy --prod --dir=.
```

### Recurring deploy

Use the one-click `scripts/03-deploy-netlify.bat` or just `git push` (when the GitHub Actions workflow is wired with NETLIFY_AUTH_TOKEN + NETLIFY_SITE_ID secrets).

## DUNS / Company info

Footer currently shows `XX-XXX-XXXX` as a placeholder. Update once issued.
