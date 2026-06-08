# Rebound Screenshot Preview Design

## Goal

Replace the CSU Fullerton Project Rebound iframe with a reliable local screenshot preview while preserving the existing portfolio, outbound project link, theme engine, layout switcher, live refresh control, footer information, and visual identity.

## Approved Approach

Use the Chrome-captured first view of the official Project Rebound website as a local portfolio asset. Render it inside the existing project frame with a subtle branded overlay and make the full preview clickable. The existing "Open Site" action remains and continues to open the official site in a new tab.

This is preferable to leaving the blocked iframe fallback because it gives visitors a truthful visual preview without bypassing Fullerton's framing restrictions. It is also more reliable than a remote screenshot service because the portfolio remains self-contained.

## Page Changes

- Replace only the Fullerton iframe and fallback markup with a local responsive image preview.
- Preserve the other three live iframe previews.
- Add a visible "Static preview" badge and an accessible label explaining that the image opens the live site.
- Keep the current project title, description, tags, and actions.
- Correct canonical, social, sitemap, robots, README, and helper-script URLs to the actual Netlify hostname.
- Update copy that incorrectly says every project is a live preview.
- Update the live-refresh switch's `aria-checked` state when toggled.

## Responsive Design

- Keep the desktop two-column project grid and existing switchboard.
- Ensure framed hero words shrink and wrap safely on narrow screens.
- Make mobile project images taller and easier to inspect.
- Stack project actions into stable full-width controls on small screens.
- Convert footer columns to a single readable mobile flow at the smallest breakpoint.
- Keep motion reduced when the device requests reduced motion.

## Verification

- Confirm the screenshot asset loads locally and from Netlify.
- Confirm the Fullerton card contains no iframe.
- Confirm the Fullerton preview and button both point to the official website.
- Confirm the remaining three iframes still initialize.
- Confirm theme, layout, and live-refresh controls work.
- Check desktop, tablet, and mobile layouts for overflow and broken images.
- Confirm scripts remain blocked from public serving.

