---
name: design-brief
description: >
  Produces a website design brief. Trigger on: "design brief", "website brief",
  "landing page brief", "brief for [company name]", "plan the website", "what
  should the website look like", "we need a launch page", "help with the landing page".
---

# Design Brief

Produces a structured website design brief. The brief is the handoff document between whoever understands the positioning and whoever builds the page — whether that's the same person or two different ones. The decision it informs: what to build, for whom, and in what order of priority.

## When to use

Use when a product needs a new website, landing page, or GTM-facing web presence. Typical triggers: preparing for launch, pivoting positioning, entering a new market segment, or an existing site performing poorly on conversion.

Do not use for internal tooling interfaces or non-web deliverables.

## Instructions

### Step 1 — Gather context

Collect these before writing anything. If information is missing, state what's missing and what assumption you're making.

Required inputs:

- **Company name** and one-sentence description
- **Target user**: specific enough to find 10 of them on LinkedIn in 5 minutes. "SMB owners" fails. "Solo accountants in the US with 10-50 clients using QuickBooks" passes.
- **Primary action**: the single thing the visitor should do (sign up, book demo, join waitlist, download, buy). One action only.
- **Stage**: pre-launch (waitlist), launch (first users), growth (scaling acquisition)
- **Existing assets**: logo, brand colors, copy, domain, any current site URL
- **Constraints**: timeline, budget range, who builds it

If the user provides a URL to an existing site, fetch it and extract: current positioning, page structure, primary CTA, obvious gaps.

### Step 2 — Surface assumptions

Before designing anything, force the key assumptions into the open:

1. **Business outcome**: what measurable result does this page need to produce in 30 days? If the answer is "awareness" or "credibility," push for a number attached to an action.
2. **User outcome**: what does the visitor get from this page that they can't get elsewhere?
3. **Riskiest assumption**: the single belief that, if wrong, makes this page waste time. Name it explicitly. Example: "property managers search for compliance tools online" or "founders will sign up without seeing a demo."

### Step 3 — Select copy framework

Choose one framework based on stage and visitor awareness:

**PAS (Problem → Agitate → Solution)** — Use when the target user has an active pain point and knows it. Most pre-seed B2B products fit here.

**AIDA (Attention → Interest → Desire → Action)** — Use when the product is novel and the visitor doesn't yet know they have a problem.

**BAB (Before → After → Bridge)** — Use when the target user is comparing alternatives.

State which framework you're using and why. Do not mix frameworks.

### Step 4 — Define the page hierarchy

Answer these five questions:

1. **Hero**: single most important message. Write as headline (under 10 words) + subheadline (under 25 words).
2. **Supporting sections**: what evidence supports the hero claim? Rank by persuasion weight.
3. **Cut**: what content does NOT belong on this page? Name at least two things.
4. **Primary action placement**: minimum — hero and bottom.
5. **Grouping**: which sections cluster together visually?

Hero variant options:
- **Centered**: headline + subheadline + CTA centered, product screenshot below. Default for most SaaS.
- **Split**: copy left, visual right. Use when the product has an interface worth showing immediately.
- **Minimal**: headline + CTA only. Use for pre-launch waitlist pages without product visuals.

### Step 5 — Select design style

Choose one style. Provide Tailwind color tokens.

- **Clean Minimal**: white background, gray-900 text, single accent. B2B tools, utility SaaS.
- **Dark SaaS**: dark background, light text, vibrant accent. Developer tools, AI products.
- **Bold Startup**: strong brand colors, large type. Consumer products, marketplaces.
- **Enterprise**: neutral palette, conservative typography. Regulated industries, large orgs.

### Step 6 — Write the content blocks

For each section in the hierarchy, write:
- **Headline** (under 8 words)
- **Body copy** (2-4 sentences, concrete, no filler)
- **Visual direction** (functional description: "screenshot showing dashboard with metrics visible," not "blue gradient background")
- **CTA text** if the section includes an action (specific verb + outcome: "Start free trial" not "Get started")

### Step 7 — SEO and technical spec

Document:
- Page title (under 60 characters)
- Meta description (under 155 characters)
- H1 (matches hero headline)
- Core Web Vitals targets: LCP < 2.5s, CLS < 0.1, INP < 200ms
- Stack recommendation with rationale (default: single HTML page with Tailwind CSS)
- Responsive priority: mobile-first or desktop-first, with reason
- Accessibility baseline: WCAG 2.1 AA

## Output format

```markdown
# Website Design Brief: [Company / Product Name]

**Prepared by:** [name]
**Date:** [date]
**Stage:** [pre-launch / launch / growth]
**Target user:** [specific description]
**Primary action:** [single CTA]

## Assumptions to test

- Business outcome: [measurable 30-day target]
- User outcome: [what state the visitor leaves in]
- Riskiest assumption: [the belief that could invalidate this page]

## Copy framework

[PAS / AIDA / BAB] — [one sentence explaining why this framework fits]

## Design style

[Clean Minimal / Dark SaaS / Bold Startup / Enterprise] — [one sentence why]
Color tokens: [bg, text, accent values or Tailwind classes]

## Hero

**Variant:** [centered / split / minimal]
**Headline:** [under 10 words]
**Subheadline:** [under 25 words]
**Visual direction:** [functional description]
**CTA:** [button text]

## Page sections (in display order)

### [Section name]
**Headline:** ...
**Body:** ...
**Visual direction:** ...
**CTA (if any):** ...

## Content to exclude

[List items explicitly cut and why]

## SEO & technical spec

- Page title: [under 60 chars]
- Meta description: [under 155 chars]
- Stack: [recommendation and rationale]
- Responsive: [mobile-first or desktop-first and why]
- Core Web Vitals: LCP < 2.5s, CLS < 0.1, INP < 200ms
- Accessibility: WCAG 2.1 AA

## Open questions

[Anything that couldn't be resolved from available inputs]
```

## Examples

**Input:** "Put together a website brief for TenantMeter. Pre-launch B2B SaaS for property managers. Helps track energy compliance across building portfolios. Target: EU property management firms, 50-500 units. They have a logo but no copy. Founder building it, aiming to launch in 2 weeks."

**Output:** (abbreviated)
- Stage: pre-launch
- Target user: EU property managers with 50-500 residential units under EPBD compliance obligations
- Primary action: Join waitlist
- Copy framework: PAS — target user has active pain (compliance tracking is manual and error-prone)
- Design style: Clean Minimal — B2B utility for a conservative industry
- Hero: Split — "Energy compliance for your whole portfolio" / dashboard mockup right
- Riskiest assumption: property managers actively search online for compliance tools

## Dependencies

- Web fetch (optional — to read existing site URLs)
- S-002 (brief-review) — to review this output before handing off to development
