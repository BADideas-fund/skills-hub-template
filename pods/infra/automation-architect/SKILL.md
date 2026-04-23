---
name: automation-architect
description: >
  Evaluates whether a task should be a workflow, agent, skill, or manual process
  before any building starts. Trigger on: "automate this", "build a workflow for",
  "I want to automate", "should this be an agent or workflow", "which tool should
  I use", "how should we build this", "set up an automation", or when someone
  describes a repetitive task without specifying the implementation approach.
---

# Automation Architect

Evaluates a described task and recommends the right implementation approach: manual process, skill, workflow (n8n/Make/Zapier), agent, or hybrid. Produces a structured recommendation with rationale, build effort, and comparison. The decision it informs: what type of system should own this task?

## When to use

Use before building any automation. This skill is the gate that prevents defaulting to the automation paradigm you already know (typically n8n workflows) when a different approach would produce better results.

Do not use for tasks already clearly defined as one-shot skills (document production, code review). Do not use for one-off tasks that won't recur.

## Instructions

### Step 1 — Understand the task

Gather or extract from context:

1. **What happens**: describe the task in 2-3 sentences — input, output, what happens in between
2. **Trigger**: what causes it to start? (Time-based, event-based, human request)
3. **Frequency**: how often? (Multiple daily, daily, weekly, monthly, ad-hoc)
4. **Judgment points**: steps where someone makes a decision that isn't a simple if/then — list them
5. **Context dependency**: does quality depend on knowing what happened in previous runs?
6. **Error handling**: can a fixed retry handle failures, or does someone need to interpret them?

### Step 2 — Classify into five levels

**Level 1 — Manual (keep as-is)**
Runs <2x/month, under 15 minutes, context changes every time. Automating costs more than it saves.
Example: drafting a one-off email for a specific situation.

**Level 2 — Skill (teach Claude how)**
Produces a document, analysis, or artifact. Runs on demand when a human invokes it. Human provides input, reviews output.
Example: IC memo, design brief, code review.

**Level 3 — Workflow (n8n / Make / Zapier)**
Deterministic: same input → same action sequence. No interpretation needed. Connects systems.
Example: new Airtable row → Slack notification, cron → report pull, webhook → email.

**Level 4 — Agent (Claude + skills)**
Requires judgment at one or more steps. Output varies based on context. Benefits from accumulated context (prior runs improve future runs).
Example: screening inbound deals, monitoring portfolio health, preparing context packages.

**Level 5 — Hybrid (workflow trigger + agent execution)**
Deterministic trigger (cron, webhook, new row) but judgment-heavy execution. The workflow handles the "when"; the agent handles the "what it means."
Example: new deal in Airtable (trigger) → agent evaluates and produces summary (execution) → result posted to Slack (delivery).

### Step 3 — Produce recommendation

State the level with rationale tied to the specific task. For each judgment point, explain why it pushes toward agent (requires interpretation) or why workflow branching handles it (simple condition).

If the task is Level 4 or 5 and the user asked for a workflow, explain the difference concretely:
- "A workflow would [do X]. An agent would [do Y]. The difference matters because [specific consequence]."
- Name what the workflow version would miss. Name what the agent version costs more to build.

### Step 4 — Estimate build effort

For the recommended approach:
- **Build time**: hours to first working version
- **Test time**: hours to validate with real data
- **Maintenance**: expected monthly maintenance effort
- **Human time saved per run**: minutes saved vs. manual

If the user asked for a different approach, estimate that too for comparison.

## Output format

```markdown
# Automation Assessment: [Task Name]

**Task:** [2-3 sentence description]
**Recommended approach:** Level [N] — [Manual / Skill / Workflow / Agent / Hybrid]

## Why this level

[2-3 sentences tied to specific judgment points and context dependency. No abstract principles.]

## What each approach would deliver

| Approach | What it does | What it misses | Build effort |
|----------|-------------|---------------|-------------|
| [Option A] | | | |
| [Option B] | | | |

(Include only relevant rows — always include recommended + most likely alternative.)

## Judgment points

[List each judgment point and state: workflow branching handles it / agent interpretation needed]

## Build effort (recommended approach)

- Build time: [hours]
- Test time: [hours]
- Monthly maintenance: [hours]
- Human time saved per run: [minutes]

## Next steps

1. [First concrete action]
2. [Second]
3. [Third if applicable]
```

## Examples

**Input:** "I want n8n to watch for new deals in Airtable and post a summary to Slack."

**Assessment:** Level 5 — Hybrid. The trigger (new Airtable row) is deterministic → n8n. But "post a summary" requires interpreting the company description, evaluating team background, assessing market fit. A workflow posts a formatted row; an agent evaluates the full context. Build: n8n watches Airtable, calls Claude via HTTP with the row data and a skill prompt, posts Claude's output to Slack.

**Input:** "Automate posting weekly portfolio metrics to Slack every Monday."

**Assessment:** Level 3 — Workflow. Pull metrics on a schedule, format, post. No judgment needed. n8n cron → HTTP request → Slack node. Build time: 1-2 hours.

## Dependencies

- S-007 (skill-builder) — for building skills recommended by this assessment
- docs/automation-rule.md — the quick-reference version of this decision framework
