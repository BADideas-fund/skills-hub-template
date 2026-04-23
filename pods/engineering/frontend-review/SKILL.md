---
name: frontend-review
description: >
  Reviews HTML, CSS, React, or website code for quality, accessibility,
  performance, and design token compliance. Trigger on: "review this code",
  "check this HTML", "audit this page", "is this accessible", "review the
  frontend", "check performance", "code review", or when someone shares code
  and asks for feedback before deploying.
---

# Frontend Review

Reviews frontend code (HTML, CSS, React, Tailwind) against quality standards for accessibility, performance, semantic correctness, design token compliance, and conversion effectiveness. Produces a graded report with specific fixes. The decision it informs: is this code ready to deploy?

## When to use

Use when someone has frontend code that needs quality review before deployment. Works on any source — a developer's draft, AI-generated code (Cursor, v0.dev), an existing live page.

Do not use for reviewing briefs or design documents (use brief-review). Do not use for generating code from scratch (use web-pipeline). Do not use for reviewing non-website documents (use document-review).

## Instructions

### Step 1 — Ingest and classify

Accept code in any form. Identify: framework, styling approach, design token presence, estimated page weight.

If reviewing a live URL, fetch the page source.

### Step 2 — Five review passes

Each pass produces severity-graded findings.

**Severity levels:**
- **Blocker**: must fix before deploy. Will break in production or violates a hard standard.
- **Major**: reduces quality significantly; should fix before deploy.
- **Minor**: noticeable issue; fix before or soon after deploy.
- **Suggestion**: optional improvement.

**Pass 1 — Semantic HTML and structure**
Check: heading hierarchy (one H1, logical H2-H6 order), semantic elements (nav, main, section, article, footer), img alt/width/height attributes, link text (no "click here"), form labels, lang attribute on `<html>`.

**Pass 2 — Accessibility (WCAG 2.1 AA)**
Check: color contrast (4.5:1 for body text, 3:1 for large text), visible focus indicators on all interactive elements, keyboard navigation for CTAs and forms, no information conveyed by color alone, aria labels where needed, skip-to-content link, prefers-reduced-motion handling.

**Pass 3 — Performance**
Check: total page weight estimate, image formats (WebP/AVIF preferred), image lazy-loading below the fold, width/height set on images (prevents CLS), font loading strategy (no render-blocking), CSS efficiency (no unused rules), JS justification (no external libraries without reason), render-blocking resources.

**Pass 4 — Design token compliance**
Check: hardcoded hex values vs CSS custom properties, spacing scale consistency, type scale consistency, magic numbers (unexplained specific pixel values).

**Pass 5 — Conversion and content**
Check: CTA visibility (above the fold?), CTA text specificity ("Start free trial" vs "Get started"), hero clarity (answers "what is this" in 5 seconds), social proof presence and specificity, visual hierarchy (is the most important thing visually dominant?), competing CTAs (too many primary actions?).

### Step 3 — Verdict

- **Deploy**: 0 blockers, 0-2 major issues, 0 inconsistencies
- **Fix then deploy**: 0 blockers, 3+ major or 1+ inconsistencies
- **Rebuild**: 1+ blockers

### Step 4 — Write fixes

For every blocker and major issue: write the exact code fix (current → replacement). For minor issues and suggestions: describe the fix concisely.

## Output format

```markdown
# Frontend Review: [Page/Component Name]

**Date:** [date]
**Verdict:** [Deploy / Fix then deploy / Rebuild]

## Summary
[2-3 sentences]

## Findings

### Blockers ([count])
**[Finding description]**
Current: `[code snippet]`
Fix: `[replacement code]`

### Major issues ([count])
[Same format]

### Minor issues ([count])
- [Finding]

### Suggestions ([count])
- [Finding]

## Scorecard

| Dimension | Grade | Key finding |
|-----------|-------|-------------|
| Semantic HTML | A/B/C/F | |
| Accessibility | A/B/C/F | |
| Performance | A/B/C/F | |
| Design tokens | A/B/C/F | |
| Conversion | A/B/C/F | |

## Priority fix list
1. [Most critical fix]
2. [Second most critical]
...
```

## Dependencies

- Web fetch (if reviewing a live URL)

## Related skills

- S-003 (web-pipeline) — produces code that this skill can review; any frontend code also accepted
- S-002 (brief-review) — for reviewing design briefs before build
