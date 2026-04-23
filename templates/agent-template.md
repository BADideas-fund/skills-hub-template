---
name: agent-name
description: >
  What this agent does, when to spawn it, and what it returns.
runtime: claude-code
model: claude-sonnet-4-6
---

# [Agent Name]

[2-3 sentences: purpose, when to use, autonomy level. An agent differs from a skill in that it runs in isolated context — it's spawned as a subprocess for tasks that need clean context or parallel execution.]

## Triggers

- [Condition that causes this agent to be spawned — e.g., "user asks for deep research on a company"]

## Inputs

- [What the agent receives: file paths, URLs, structured data, text]

## Workflow

1. [Step 1 — what the agent does]
2. [Step 2]
3. [Return result to parent / write output file / post to channel]

## Output

[What the agent returns: file path, structured JSON, summary paragraph]

## Skills used

- S-NNN (skill-name) — [how and when this skill is invoked]

## Autonomy boundaries

**May do without confirmation:**
- [Actions the agent can take independently]

**Must confirm before:**
- [Actions requiring user approval — file deletion, external posts, irreversible operations]
