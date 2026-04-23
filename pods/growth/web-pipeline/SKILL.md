---
name: web-pipeline
description: >
  End-to-end pipeline from design brief to shipped website. Trigger on:
  "build this website", "code this page", "implement the brief", "turn this
  into a site", "build the landing page", "create the HTML", or when someone
  has a completed design brief and wants to produce the actual page.
---

# Web Pipeline

Takes a design brief or equivalent spec and produces a fully coded, deployable website. Covers design system setup, frontend development, SEO implementation, accessibility, and quality review. The decision it informs: is this page ready to deploy?

## When to use

Use when someone has a brief, spec, or detailed description of what a website should contain and wants it built. The input can come from any source — a brief produced by design-brief, a Notion doc, a conversation, a PDF.

If the input lacks enough detail to build from, flag what's missing and suggest running design-brief first.

Do not use for reviewing existing pages — use brief-review for briefs, frontend-review for code.

## Instructions

### Phase 1 — Extract build spec

Read the input and extract into a structured build checklist:

1. **Pages**: list every page with its URL path
2. **Sections per page**: ordered list with headlines, copy, visual direction
3. **Design tokens**: background color, text color, accent color, font stack (default: Inter), spacing scale (4px base), border radius (6px default)
4. **Components needed**: header, hero, section, CTA, footer, testimonial card, feature card, form
5. **Assets needed**: every image, icon, or visual element — flag which exist and which need sourcing
6. **SEO elements**: page title, meta description, OG tags, structured data schemas
7. **Performance budget**: Core Web Vitals targets (LCP < 2.5s, CLS < 0.1, INP < 200ms)

If any required element is missing, state the assumption you'll make and proceed.

### Phase 2 — Set up design tokens

Create CSS custom properties for all design values. Every color, spacing, and typography value in the final code must reference these tokens. No hardcoded values.

### Phase 3 — Build the page

Produce a single HTML file with inline CSS and minimal JS. Rules:

- Semantic HTML elements throughout
- WCAG 2.1 AA accessibility (alt text, focus styles, 4.5:1 contrast, keyboard navigation)
- No external JS dependencies unless justified
- Total HTML under 50KB before images
- Images: WebP or AVIF, width/height attributes set, lazy-load below the fold

### Phase 4 — Self-review

Before outputting: check heading hierarchy, alt text on all images, contrast ratios, responsive breakpoints, CTA visibility, and page weight estimate. Fix any failures.

### Phase 5 — Deliver

Output the complete HTML file plus a build report stating: what was built, assumptions made, self-review results, remaining open items.

## Output format

Primary output: complete deployable HTML file.

Accompanied by:
```markdown
# Build Report: [Page Name]

**Built from:** [brief / spec / conversation]
**Date:** [date]

## What was built
[List of pages and sections]

## Assumptions made
[Any gaps filled with assumptions]

## Self-review results
[Summary of Phase 4 check — pass/fail per dimension]

## Open items
[What the author needs to do before launch]
```

## Dependencies

- Web fetch (if brief references assets at URLs)

## Related skills

- S-001 (design-brief) — produces briefs for this pipeline; any spec format also works
- S-002 (brief-review) — can validate a brief before build
- S-005 (frontend-review) — can audit the output code after this skill completes
