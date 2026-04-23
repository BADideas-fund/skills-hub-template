---
name: document-review
description: >
  Reviews any written document against quality standards. Trigger on: "review
  this document", "check this before it goes out", "give me feedback on this",
  "review this memo", "check this proposal", "edit this draft", "is this ready
  to send", "review this investor update", "proofread this".
---

# Document Review

Reviews any written document — proposal, investor update, internal memo, report, pitch deck script — against quality standards. Produces severity-graded findings with concrete fixes. The decision it informs: is this ready to send, or does it need revision?

## When to use

Use when someone has a document and wants it evaluated before sending. Works on documents in any format.

Do not use for reviewing website briefs (use brief-review) or code (use frontend-review).

## Instructions

### Step 1 — Classify the document

Identify:
- **Type**: proposal, investor update, memo, report, pitch deck script, contract, other
- **Audience**: internal (team) vs. external (customer, investor, press, regulator)
- **Purpose**: inform, persuade, document a decision, get approval, request action

The classification determines the standard applied. An investor update is held to different standards than an internal meeting memo.

### Step 2 — Establish review criteria

Based on document type, define what "good" looks like before reviewing. State these criteria to the user at the start so they can align or override.

Common criteria:
- **Clarity**: can the reader understand the main point in under 30 seconds?
- **Specificity**: are all claims anchored to facts, numbers, or labeled assumptions? No superlatives, no vague language.
- **Completeness**: are all required sections present? Is there a clear ask or next step?
- **Conciseness**: can any sentences or sections be cut without losing meaning?
- **Audience fit**: is the vocabulary, level of detail, and tone appropriate for the recipient?

### Step 3 — Multi-pass review

**Pass 1 — Structure**: are sections in the right order? Is the opening clear about the document's purpose? Does it end with a clear ask or conclusion?

**Pass 2 — Specificity**: for every claim, ask: is this anchored to a fact, number, quote, or labeled assumption? Flag any claim that isn't.

**Pass 3 — Conciseness**: identify sentences or sections that could be cut without losing meaning. Be specific — cite line or section.

**Pass 4 — Audience fit**: is the vocabulary appropriate? Are technical terms explained if the audience needs it? Is the tone calibrated to the relationship?

### Step 4 — Grade findings by severity

- **Showstopper**: fundamental problem that will undermine the document's purpose
- **Gap**: missing element that reduces effectiveness
- **Inconsistency**: two parts contradict each other
- **Underspecified**: element present but lacking enough detail to act on
- **Suggestion**: improvement that raises quality but isn't blocking

### Step 5 — Produce concrete fixes

For every showstopper, gap, and inconsistency: write the concrete fix. Not "improve the opening" — rewrite the opening. The review output should be actionable in one pass.

## Output format

```markdown
# Document Review: [Document Name]

**Date:** [date]
**Document type:** [type]
**Audience:** [internal / external — who specifically]
**Purpose:** [what this document is trying to accomplish]
**Verdict:** [Ready / Revise / Rework]

## Summary
[2-3 sentences on overall quality and the most important finding]

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
| Clarity (30-second read) | pass / fail |
| Specificity (all claims anchored) | pass / fail |
| Completeness (all sections present) | pass / fail |
| Conciseness (no filler) | pass / fail |
| Audience fit | pass / fail |
| Clear ask / next step | pass / fail |

## Next steps
[1-3 sentences on what to do before sending]
```

## Examples

**Input:** "Review this investor update before I send it out" + [document pasted]

**Output:** Document type: investor update. Audience: LPs. Verdict: Revise. Main finding: no clear ask — the document reports activity but doesn't tell investors what it needs from them. Fix: add a final section: "What we need from you: [specific ask]."

## Dependencies

- None (no MCPs required)
