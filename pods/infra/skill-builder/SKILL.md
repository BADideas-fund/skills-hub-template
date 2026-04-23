---
name: skill-builder
description: >
  Guides the creation of a new skill in this skills hub. Trigger on: "build
  a new skill", "add a role", "teach Claude how to do X", "add a new capability",
  "I want Claude to know how to do Y", "create a skill for", "codify this process".
---

# Skill Builder

Guides you through creating a production-quality SKILL.md for a new task. Produces a complete skill file ready to add to the repo, plus the REGISTRY.md entry and pod CLAUDE.md update. The decision it informs: is this task codified well enough to run consistently across the team?

## When to use

Use when someone has identified a repeating task and wants to codify it as a skill. Works best when the person already has an informal process — even a rough one — that they want to make consistent.

Do not use for building agents (use the agent template) or n8n workflows (use automation-architect first).

## Instructions

### Step 1 — Concept extraction

Ask or extract from context:

1. **Task name**: what would you call this role? (2-3 words, lowercase hyphenated)
2. **What it produces**: one sentence — what does a user get from running this skill?
3. **Trigger phrases**: what would a team member actually say when they want this? List 5-6 natural language phrases.
4. **Steps**: walk through the process informally — what happens first, second, third?
5. **Output format**: what does good output look like? Is it a document, a report, a decision, structured data?
6. **Dependencies**: does this skill need any MCPs, API keys, or other tools?
7. **Who uses it**: which team member and in which environment (Claude Desktop, Claude Code, NanoClaw)?

If the user can't answer step 4 in detail, the skill isn't ready to codify — it needs more observation of the actual process first.

### Step 2 — Pod assignment

Identify which pod the skill belongs to. Options:
- **growth**: website, landing page, design, copy
- **content**: document review, writing, proposals
- **engineering**: code review, QA, technical decisions
- **infra**: automation, skill building, platform tools
- **other**: if none fit, propose a new pod name and add it to the pod index in CLAUDE.md

If the skill spans multiple pods, assign to the dominant domain.

### Step 3 — Write the SKILL.md

Produce the complete SKILL.md following the standard structure:

```yaml
---
name: [skill-name]
description: >
  [trigger-focused description with natural language phrases]
---
```

Body sections:
- **[Skill Name]** heading (use the role name)
- Purpose paragraph (2-3 sentences: what it produces, who uses it, what decision it informs)
- **When to use** section (explicit inclusion and exclusion rules)
- **Instructions** section with numbered steps (imperative form, explain WHY not just WHAT)
- **Output format** section (structural skeleton with headers and placeholders)
- **Examples** section (at least one realistic input/output pair)
- **Dependencies** section (MCPs, tools, other skills, or "None")

Constraints to enforce:
- Under 500 lines total
- Every instruction step explains why, not just what
- Output format includes a skeleton template, not just a description of sections
- At least one example with a realistic input

### Step 4 — Write the supporting artifacts

After the SKILL.md, produce:

**REGISTRY.md row** (copy-paste ready):
```
| S-[NEXT ID] | [skill-name] | [pod] | draft | all | — | pods/[pod]/[skill-name]/SKILL.md | None | [one sentence description] |
```

**Pod CLAUDE.md addition** (add to the Skills table):
```
| [skill-name] | draft | [trigger keywords] |
```

**CHANGELOG.md entry**:
```
[2026-MM-DD] Add: [skill-name] — [one sentence description] (S-[ID])
```

**Directory structure to create**:
```
pods/[pod-name]/[skill-name]/
├── SKILL.md
└── evals/
    └── evals.json     (3 test prompts)
```

### Step 5 — Produce test prompts

Write 3 realistic test prompts for `evals/evals.json`:

```json
{
  "skill_name": "[skill-name]",
  "evals": [
    {
      "id": 1,
      "prompt": "[most common thing a team member would say]",
      "expected_output": "[what good output looks like]"
    },
    {
      "id": 2,
      "prompt": "[edge case or variation]",
      "expected_output": "[what good output looks like]"
    },
    {
      "id": 3,
      "prompt": "[another realistic variation]",
      "expected_output": "[what good output looks like]"
    }
  ]
}
```

### Step 6 — Review against quality criteria

Before delivering, check:

- [ ] Description field includes natural language trigger phrases
- [ ] Every instruction step explains WHY
- [ ] Output format section contains a structural skeleton (not just section names)
- [ ] At least one example with a realistic input
- [ ] Dependencies listed (or "None")
- [ ] Under 500 lines
- [ ] REGISTRY.md row, pod CLAUDE.md addition, and CHANGELOG entry included

## Output format

Deliver in this order:
1. Complete `SKILL.md` content (ready to paste)
2. `evals/evals.json` content
3. REGISTRY.md row (copy-paste ready)
4. Pod CLAUDE.md change (which line to add)
5. CHANGELOG.md entry

## Examples

**Input:** "I want Claude to write our weekly investor update. We send it every Friday. It covers what we shipped, what's blocked, what's next, and one metric that matters this week."

**Output:** SKILL.md for `weekly-investor-update` in the content pod, with trigger phrases like "write this week's investor update", "Friday update", "investor email", instructions covering the four sections, output format with the exact structure we use, and 3 test prompts.

## Dependencies

- None (no MCPs required)
