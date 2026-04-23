---
name: skill-name
description: >
  What this skill does and when Claude should invoke it. Be specific about
  trigger conditions — include keywords a user would naturally say. Err on
  the side of over-triggering rather than under-triggering.
---

# [Skill Name]

[2-3 sentences: what this skill produces, who uses it, and what decision it informs.]

## When to use

[Explicit inclusion/exclusion rules. "Use when X. Do not use for Y."]

## Instructions

[The core workflow. Use imperative form ("Identify...", "Produce...", "Compare...").
Break into numbered steps. Explain WHY each step matters, not just WHAT to do.]

### Step 1 — [Name]

[Instructions for this step. Why does this step matter?]

### Step 2 — [Name]

[Instructions for this step.]

## Output format

[Define what the user gets. Include a structural skeleton — not just section names, but headers and placeholders.]

```markdown
# [Output Title]

## [Section 1]
[what goes here]

## [Section 2]
[what goes here]
```

## Examples

**Input:** [A realistic prompt a team member would actually type]

**Output:** (abbreviated) [What the skill produces — enough to show shape and voice]

## Dependencies

- [MCP, tool, or other skill required]
- None — if no dependencies
