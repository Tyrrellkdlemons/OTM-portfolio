# Rebound Screenshot Preview Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the blocked CSU Fullerton Rebound iframe with a local screenshot preview and ship a polished, responsive portfolio update.

**Architecture:** Keep the static HTML/CSS/JavaScript structure. The Rebound card becomes a normal outbound link containing a local image, while the existing iframe loader continues to manage the other three cards. Metadata, documentation, helper scripts, and Netlify configuration use the actual production hostname.

**Tech Stack:** Static HTML5, CSS, vanilla JavaScript, GitHub, Netlify CLI, Chrome screenshots.

---

### Task 1: Integrate the Rebound screenshot

**Files:**
- Create: `assets/media/csuf-project-rebound-preview.png`
- Modify: `index.html`
- Modify: `assets/css/portfolio.css`

- [ ] **Step 1: Verify the screenshot**

Run:

```powershell
Get-Item assets/media/csuf-project-rebound-preview.png
```

Expected: the file exists and has a non-zero length.

- [ ] **Step 2: Replace the Rebound iframe**

Replace the Rebound `.project-frame-wrap` contents with an outbound `.project-static-preview` link containing the screenshot, a "Static preview" badge, and a "View live site" overlay.

- [ ] **Step 3: Add image-preview styles**

Add stable aspect ratio, `object-fit: cover`, top positioning, hover zoom, overlay contrast, keyboard focus, and theme-compatible badge styles.

### Task 2: Correct copy, URLs, and control state

**Files:**
- Modify: `index.html`
- Modify: `assets/js/portfolio.js`
- Modify: `README.md`
- Modify: `robots.txt`
- Modify: `sitemap.xml`
- Modify: `docs/deploy/NETLIFY_GITHUB_WORKFLOW.md`
- Modify: `scripts/00-menu.bat`
- Modify: `scripts/03-deploy-netlify.bat`
- Modify: `scripts/07-open-browser.bat`
- Modify: `scripts/08-status.bat`
- Modify: `scripts/10-first-time-setup.bat`
- Modify: `scripts/DEPLOY-ALL.bat`

- [ ] **Step 1: Replace stale production URLs**

Use `https://otmworkshops-portfolio.netlify.app` and Netlify project name `otmworkshops-portfolio`.

- [ ] **Step 2: Correct mixed-preview copy**

Describe the portfolio as using live and captured previews instead of claiming every card is a live iframe.

- [ ] **Step 3: Synchronize the live switch accessibility state**

Set `aria-checked` to `"true"` or `"false"` whenever the toggle changes.

### Task 3: Improve narrow-screen presentation

**Files:**
- Modify: `assets/css/portfolio.css`
- Modify: `index.html`

- [ ] **Step 1: Protect framed hero text**

At phone widths, use full-width framed lines, safe padding, `white-space: normal`, and bounded font sizes.

- [ ] **Step 2: Improve card controls**

Use a taller preview ratio, full-width project actions, and stable touch target sizes.

- [ ] **Step 3: Refine the mobile footer and switchboard**

Use a single-column footer at the smallest breakpoint and compact horizontally scrollable theme controls without clipping.

### Task 4: Validate locally

**Files:**
- Test: all static files

- [ ] **Step 1: Run Netlify build**

```powershell
npx --yes netlify-cli build
```

Expected: `Netlify Build Complete`.

- [ ] **Step 2: Run static reference validation**

Check local `href`, `src`, and `srcset` paths from every HTML and CSS file. Expected: no missing local files.

- [ ] **Step 3: Run browser checks**

Verify desktop, tablet, and mobile widths for no horizontal overflow, no broken images, working theme/layout/live switches, three remaining iframes, and one static Rebound preview.

### Task 5: Publish and verify

**Files:**
- Modify: `.github/workflows/netlify-deploy.yml`
- Generated locally: `.netlify/state.json` (gitignored)

- [ ] **Step 1: Validate workflow assets**

Add checks for the screenshot, CSS, and JavaScript files.

- [ ] **Step 2: Commit and push**

Commit the intended files to `main` and push to `Tyrrellkdlemons/OTM-portfolio`.

- [ ] **Step 3: Link and deploy Netlify**

Link site ID `f0b72b8b-1a69-4c3d-b6e7-348a7cadce62`, run a production deploy, and capture the deploy URL.

- [ ] **Step 4: Verify production**

Confirm the public page and screenshot return `200`, scripts return `404`, the Rebound card is static, and the live controls work.

