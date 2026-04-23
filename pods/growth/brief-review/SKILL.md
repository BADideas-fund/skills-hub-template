---
name: brief-review
description: >
  Evaluates an existing website brief, landing page draft, or design document
  against quality standards. Trigger on: "review this brief", "evaluate this
  draft", "is this brief good", "is this ready to build", "review this design
  doc", "check this before we hand it off".
---

# Brief Review

Evaluates a website brief, landing page draft, or live page against quality standards for audience specificity, copy persuasion logic, visual hierarchy, and technical buildability. Produces severity-graded findings with concrete fixes. The decision it informs: is this ready to hand off, or does it need revision?

## When to use

Use when someone has a brief, draft, or live page and needs it evaluated before proceeding. Works on briefs from any source.

Do not use for: generating new briefs (use design-brief instead), reviewing code (use frontend-review), or reviewing non-website documents like proposals (use document-review).

## Instructions

### Step 1 — Ingest the artifact

Accept the input in any form: markdown brief, HTML, live URL, pasted text, screenshot. Identify the type:

- **Brief document**: evaluate against website brief standards
- **HTML/code draft**: evaluate content AND implementation quality
- **Live URL**: fetch and evaluate conversion, SEO, accessibility, performance
- **Screenshot or description**: evaluate what's visible, flag what can't be assessed

State clearly what you're evaluating and in what format.

### Step 2 — Multi-perspective review

Evaluate from three perspectives. For each, state 2-4 findings with severity levels.

**Severity levels:**
- **Showstopper**: blocks handoff. Cannot proceed without fixing.
- **Gap**: missing element that reduces effectiveness by >20%.
- **Inconsistency**: two parts contradict each other.
- **Underspecified**: element exists but lacks detail to act on.
- **Suggestion**: improvement that raises quality but isn't blocking.

**Perspective 1 — Product (does this serve the right user?)**
Is the target user specific enough? Does the primary action match the stage? Are the assumptions testable? Does the copy framework match the user's awareness level?

**Perspective 2 — Design (does this communicate clearly?)**
Is the page hierarchy weighted correctly? Does the hero answer "what is this" and "why should I care" within 5 seconds? Is the visual direction functional, not decorative?

**Perspective 3 — Engineering (can this be built?)**
Is the tech spec complete enough to build from? Are performance targets stated? Is the accessibility baseline defined? Does the stack match the constraints?

### Step 3 — Verdict

Count findings by severity. Produce a readiness verdict:

- **Ready**: 0 showstoppers, 0-1 gaps, 0 inconsistencies
- **Revise**: 0 showstoppers, 2+ gaps or 1+ inconsistencies
- **Rework**: 1+ showstoppers

### Step 4 — Fix list

For every showstopper, gap, and inconsistency: write the concrete fix. Not "improve the headline" — write the improved headline. The review output should be actionable in one pass.

## Output format

```markdown
# Brief Review: [Artifact Name]

**Date:** [date]
**Artifact type:** [brief / HTML / live URL / screenshot]
**Verdict:** [Ready / Revise / Rework]

## Summary
[2-3 sentences]

## Findings

### Showstoppers ([count])
- [Finding] → Fix: [concrete fix]

### Gaps ([count])
- [Finding] → Fix: [concrete fix]

### Inconsistencies ([count])
- [Finding] → Fix: [concrete fix]

### Underspecified ([count])
- [Finding]

### Suggestions ([count])
- [Finding]

## Scorecard

| Dimension | Status |
|-----------|--------|
| Target user specificity | pass / fail |
| Business outcome measurability | pass / fail |
| Copy framework alignment | pass / fail |
| Hero clarity (5-second test) | pass / fail |
| Page hierarchy logic | pass / fail |
| Tech spec completeness | pass / fail |
| Accessibility baseline | pass / fail |

## Next steps
[1-3 sentences on what to do before proceeding]
```

## Dependencies

- Web fetch (if evaluating a live URL)

## Related skills

- S-001 (design-brief) — produces briefs that this skill can review
- S-005 (frontend-review) — handles code-level review after build
