# Skills Hub — Complete Reference

Architecture, patterns, and operations guide for running a skills hub. Version 1.0. Production-tested across a team of 11 AI roles.

---

## 1. Introduction

### What is a skills hub

A skills hub is a version-controlled folder that makes Claude smarter about your company. It contains one file per task type — each file (a "skill") encodes how a specific job gets done: your audience, your standards, your process, your output format.

When Claude reads this folder, it routes requests to the right skill automatically. No slash commands. No IDs to remember. Describe what you need, Claude matches it, executes.

### Why skills drift without a system

Every team using Claude builds up prompts and processes. The problem is what happens to them.

They scatter across sessions that expire. Two people write different versions of the same process. Claude loads whichever it finds first and averages them. Nobody knows what's current. By month three the accumulated mess has more drag than value.

The canonical solution: one folder, one version per skill, version-controlled, organized by domain. When someone improves a skill, every future session uses the improved version. When someone leaves, the knowledge stays.

### What you get from this template

Seven production-tested skills across four domains, plus the infrastructure to grow them:

- A routing system (CLAUDE.md) that matches requests to the right skill automatically
- A registry (REGISTRY.md) that tracks every skill with ID, status, owner, and dependencies
- A contribution workflow (CONTRIBUTING.md, CI check) that prevents ID conflicts and regression
- A feedback system (logs/feedback.json) that captures what breaks
- A style guide and architecture reference for consistent skill quality

The skills compound. Each one you add makes the system more useful. The infrastructure keeps them from drifting.

---

## 2. Architecture — Thin Harness, Fat Skills

### The core principle

CLAUDE.md is the thin harness. It's ~100 lines: company context, pod index, routing protocol. Its only job is to match a request to the right skill and load the right file. All the intelligence is in the skills.

Skills are the fat. A skill is a markdown file that encodes how a specific job gets done. It explains the reasoning behind each step, defines the output format exactly, and gives Claude enough context to produce consistent, specific results. The skill is the AI version of a playbook.

This split matters because CLAUDE.md is loaded on every session. If it's fat, Claude spends tokens on routing instructions instead of your actual request. Thin harness, fat skills = Claude reads routing instructions fast and spends most of its context on executing the task.

### Routing flow

```
User request
    ↓
CLAUDE.md (root router)
    → match to pod
    ↓
pods/[pod-name]/CLAUDE.md (pod router)
    → match to skill
    ↓
pods/[pod-name]/[skill-name]/SKILL.md (execute)
    → optional: load references/ for deep context
    → produce output
```

### Pod isolation

Each pod is self-contained. The pod's CLAUDE.md lists every skill in the pod, describes when each triggers, and optionally sets pod-level standards (e.g., a design pod might set visual conventions, a fund-ops pod might set regulatory constraints).

This means you can add or rewrite an entire pod without touching the root CLAUDE.md (unless you're adding a new pod to the index).

Cross-pod work: run each pod's skill independently. Don't assume one pod's output format is another pod's input format — route the intermediate result through the user.

### Session context

Skills-hub is a session-first system. Claude reads CLAUDE.md when a session starts (or when the repo is the working directory in Claude Code), then reads the relevant pod CLAUDE.md and SKILL.md when a request arrives.

**Implication:** CLAUDE.md changes take effect in the next session, not the current one. If you edit a skill and want to test it, start a new session.

---

## 3. Quick Start (5 minutes)

**1. Fill in company context** (`CLAUDE.md` lines 3-9):

```markdown
| Company | [Company name] |               →    | Company | Acme Inc |
| What you do | [One sentence] |           →    | What you do | SaaS tool that lets property managers track energy compliance |
| Stage | [Pre-seed / Seed / Series A] |   →    | Stage | Seed |
| Target audience | [specific] |           →    | Target audience | EU property managers, 50-500 units |
| Current priority | [this month] |        →    | Current priority | Close 5 new customers before end of Q2 |
```

**2. Connect Claude to the folder:**

- **Claude Desktop / Cowork:** folder icon → Select folder → navigate to the repo → new session → say "hi"
- **Claude Code:** `cd ~/Documents/skills-hub && claude`

**3. Test routing:**

Say: `"Put together a website brief for our product launch."`

Claude should load `pods/growth/CLAUDE.md` and run `design-brief`.

If it doesn't route correctly, check that your company context in CLAUDE.md is filled in (generic values produce generic behavior).

---

## 4. Company Context

The context table in `CLAUDE.md` is the most important file in the repo. It's the difference between Claude producing a generic landing page brief versus a brief for your specific product, your specific audience, your specific stage.

### What each field does

**Company** — Sets the name used in all outputs. Headers, file names, document footers.

**What you do** — The one-sentence constraint that all output must stay consistent with. If a skill's output contradicts this sentence, it's wrong. Be specific: "SaaS for property managers tracking EU energy compliance" is better than "proptech startup."

**Stage** — Affects every recommendation. Pre-seed advice is different from Series A advice. A skill that knows you're pre-launch won't recommend a pricing page before you have customers. Update this when your stage changes.

**Target audience** — The specificity test: can you find 10 of these people on LinkedIn in 5 minutes? "SMB owners" fails. "Solo accountants in the US with 10-50 clients using QuickBooks" passes. Specific audience = specific skill output.

**Current priority** — What matters this month. Skills that generate strategy or plans will orient around this. Update monthly. If your priority is "fundraise," deal memos will come before growth work. If it's "launch," the reverse.

### Keeping it current

Set a monthly reminder to update the priority field. Update stage and audience when they change materially. Keep all other fields stable unless your positioning fundamentally shifts.

---

## 5. Routing Protocol

The routing protocol in CLAUDE.md is the 6-step system Claude follows on every request. Understanding it helps you write better pod CLAUDE.md files and better skills.

### The 6 steps

**1. Match the pod.** Claude reads the pod descriptions in CLAUDE.md and matches your request to one. Most requests map to one pod. If a request is genuinely ambiguous, Claude asks which angle matters more.

**2. Load the pod.** Claude reads `pods/[pod-name]/CLAUDE.md`. This is where pod-level context lives — conventions, team members using this pod, when to use vs. not use each skill.

**3. Confirm before multi-step work.** If the skill involves 3+ steps or produces a substantial deliverable, Claude says what it's about to do in 1-2 sentences and waits for confirmation. Quick reviews don't need confirmation.

**4. Classify the writing standard.** Any task producing written output: Claude determines whether it's internal (docs, skill files, specs) or external-branded (customer-facing copy, investor updates, social). Internal follows `docs/style-guide.md`. External-branded follows style-guide plus your company's brand voice (define this in `docs/style-guide.md`).

**5. Execute.** Claude follows SKILL.md instructions, using the company context table to make output specific.

**6. Cross-pod work.** If a task spans pods, Claude runs each pod's skill independently, routing intermediate output through the user rather than assuming format compatibility.

### Planned skills

When a user requests a skill that's in REGISTRY.md with `status: planned`, Claude tells them the role doesn't exist yet and offers to help with general capabilities. It does not fabricate a SKILL.md path or simulate the skill.

---

## 6. Pod Architecture

### What makes a good pod

A pod should be MECE: mutually exclusive, collectively exhaustive. No two pods should overlap on the same request type. Together, all pods should cover every request type your team would send.

The natural way to find pod boundaries: think about domain specialists. A design pod owns everything a designer would handle. An engineering pod owns everything an engineer would handle. The test: given any request, there should be exactly one pod it belongs to.

### Pod CLAUDE.md structure

```markdown
# [Pod Name]

[2-3 sentences: what this pod covers, who on the team uses it, when to route here.]

## Skills

| Skill | Status | Trigger |
|-------|--------|---------|
| skill-name | live | keywords that trigger this skill |
| skill-name | planned | keywords that will trigger this once built |

## Standards

[Pod-level conventions. Optional. Examples: visual style for a design pod, regulatory constraints for a compliance pod, voice guidelines for a writing pod.]
```

### When to add a new pod vs. a new skill

Add a skill to an existing pod when: the request type belongs to that domain and the pod exists.

Add a new pod when: the request type is a genuinely new domain with 3+ skills warranting its own CLAUDE.md. Don't create a pod for one skill — put it in the closest existing pod and move it later.

### The `_private/` pattern

If some pods contain proprietary strategy, investment criteria, or sensitive playbooks that shouldn't ship in the template, put them in `pods/_private/`. Add `pods/_private/` to `.gitignore`. The root CLAUDE.md can still reference them — they just won't be visible in the public repo.

---

## 7. Skill Format

Every SKILL.md follows the same structure. The structure isn't arbitrary — each section serves a specific function in making Claude's output consistent and specific.

### YAML frontmatter

```yaml
---
name: skill-name
description: >
  What this skill does and when Claude should invoke it. Be specific about
  trigger conditions — include keywords a user would naturally say. Err on
  the side of over-specifying rather than under-specifying. Under-triggering
  is a bigger problem than over-triggering: a skill that runs when it shouldn't
  can be corrected; a skill that never runs isn't useful.
---
```

The `description` field is the trigger. Claude reads it to decide whether a request matches this skill. If users report that Claude isn't routing to the right skill, the fix is almost always in the description field — add the natural language phrases users actually say.

### Body structure

After frontmatter, the skill body follows this order:

**Purpose (required):** 2-3 sentences. What this skill produces, who uses it, what decision it informs.

**When to use (optional):** Explicit inclusion/exclusion rules. "Use when X. Do not use for Y." Most useful when the description field alone doesn't settle edge cases.

**Instructions (required):** The core workflow. Imperative form: "Identify the target user" not "You should identify the target user." Numbered steps. Each step explains WHY, not just WHAT. Claude adapts better when it understands the reasoning.

**Output format (required):** What the user gets. Include a structural skeleton or template — not just a description of sections, but the actual headers and placeholders. Claude will produce more consistent output if it's filling in a template than if it's free-forming a structure.

**Examples (required):** At least one realistic input/output pair. The input should be something a real team member would actually type. The output can be abbreviated — enough to show the shape and voice, not a full production artifact.

**Dependencies (required):** MCPs, tools, or other skills needed. If none, write "None." This is what prevents skills from silently failing in environments where dependencies aren't available.

### Size limit

Keep skills under 500 lines. If you're approaching this limit, move reference material to `references/` inside the skill directory:

```
pods/[pod]/[skill]/
├── SKILL.md
└── references/
    ├── positioning-frameworks.md
    └── competitor-data.md
```

Reference files are loaded on demand ("for competitive positioning, read `references/positioning-frameworks.md`"), not upfront. This keeps the main skill lean and the session context uncluttered.

### Skill naming

- Directory names: lowercase, hyphenated, 2-3 words. `competitor-analysis` not `competitiveIntelligenceDeepDive`.
- Reference files: lowercase, hyphenated. `positioning-frameworks.md`.
- Scripts: lowercase, hyphenated. `extract-metrics.py`.

---

## 8. Agent vs. Skill vs. Automation

Most tasks fit one of three patterns. Choosing the wrong pattern wastes build time and produces worse output.

### Decision tree

```
Does the task need to run without a human present?
├── No → Skill (user invokes on demand)
└── Yes →
    Is the execution purely deterministic (same input = same action sequence)?
    ├── Yes → Workflow (n8n, Make, Zapier)
    └── No (requires judgment, interpretation, quality assessment) →
        Is the trigger deterministic (cron, webhook, event)?
        ├── No → Agent (user-triggered, judgment-heavy)
        └── Yes → Hybrid (deterministic trigger + agent execution)
```

### Skills

One-shot, user-triggered, Claude Code or Claude Desktop context. The user provides input, Claude executes the skill, user reviews the output.

**Use for:** document production, analysis, code review, any task where a human is present and provides the input.

**Don't use for:** tasks that need to run on a schedule, react to events, or process data without a human in the loop.

### Agents

Isolated context, may be multi-turn, can be spawned in parallel. Agents are useful when the task benefits from a clean context window (deep research without conversation history in the way) or when you want parallel execution across multiple instances.

**Use for:** deep research, parallel document processing, tasks that need to run independently of the current conversation.

**Don't use for:** simple one-shot tasks that a skill handles cleanly.

### Workflows (n8n / Make / Zapier)

Deterministic data movement. Same input → same action sequence. No interpretation.

**Use for:** syncing data between tools, time-triggered reminders, webhook-to-action pipes, any task where a fixed flowchart covers every case.

**Don't use for:** tasks where quality varies by context, tasks that need to read between the lines, tasks where what counts as "correct" changes.

### Hybrid

Deterministic trigger (cron, webhook, new row) + judgment-heavy execution (agent + skills). The workflow handles the "when" and the "what data"; the agent handles the "what it means" and "what to do."

**Example:** New deal appears in Airtable (workflow trigger) → agent evaluates deal quality and produces IC summary (skills execution) → result posted to Slack (workflow delivery).

### The automation-architect skill

When you're not sure which pattern fits, run S-006 (automation-architect). It asks 7 questions about the task (trigger, frequency, judgment points, context dependency, error handling) and produces a structured recommendation with build effort estimates.

---

## 9. Runtime Environments

Skills-hub runs across four environments. Write skills that work in all of them (tagged `all`) unless the skill genuinely needs environment-specific tools.

### Claude Desktop

The default for non-technical users. Mount the skills-hub folder in Claude Desktop's folder picker (click the folder icon in the top-left of the interface). Each new session loads CLAUDE.md automatically.

**Characteristics:** Session-scoped context. No persistent file access between sessions (only through the mounted folder). Great for interactive skill execution.

**MCP support:** Claude Desktop supports MCPs configured in the app settings. If a skill depends on an MCP (Airtable, Notion, Slack), it only works in environments where that MCP is connected.

### Claude Code

For technical users. `cd ~/Documents/skills-hub && claude`. CLAUDE.md loads automatically when the repo is the working directory.

**Characteristics:** Full file system access. Can commit and push. Good for skills that need to write files (code, briefs, specs) and commit them to git.

### NanoClaw

Container-hosted Claude. Runs in Docker, can be deployed to a server. Good for skills that run on a schedule or react to webhooks.

**Characteristics:** Headless. Long-running. Can be given MCPs and tools on container startup. Tag skills that only work in NanoClaw as `nanoclaw` in REGISTRY.md.

### n8n (workflow runtime)

n8n workflows can invoke Claude via HTTP node or Claude node. Skills can be referenced in the workflow's system prompt or as step-level instructions.

**Characteristics:** Deterministic trigger → Claude execution → structured output → next workflow step. Claude is one node in a larger pipeline.

### Runtime tagging

Tag skills in REGISTRY.md:

| Tag | Meaning |
|-----|---------|
| `all` | Works in any environment. No env-specific dependencies. |
| `cowork` | Requires MCPs only available in Claude Desktop (Notion, Airtable, Slack MCPs). |
| `nanoclaw` | Requires container environment or long-running session. |
| `n8n` | Invoked from n8n workflow. |

Default: tag `all` unless you know the skill won't work somewhere.

---

## 10. Scaling with a Team

### Pod ownership

Assign one person as pod owner. The pod owner is responsible for:
- Quality of skills in the pod
- Reviewing PRs that touch their pod's skills
- Deprecating skills that are no longer used

Pod ownership is in REGISTRY.md (Owner column). Keep it current.

### Skill ownership

Each skill has one owner in REGISTRY.md. The owner is on the hook for:
- Reviewing improvement PRs
- Updating the skill when the underlying process changes
- Testing the skill quarterly

### PR review process

- **Minor edits** (typo, clarification, new example): one approval, no waiting period
- **Behavioral changes** (new step, changed output): 48-hour waiting period before merge
- **New skills**: one approval from the pod owner or platform maintainer

### The no-deletion rule

No skill is ever deleted from the repo. Deprecation instead: change status to `deprecated` in REGISTRY.md, move directory to `_deprecated/`, add a note pointing to the replacement. The `_deprecated/` folder is permanent.

Why: people build workflows and habits around skills. Deletion breaks them without warning. A deprecated skill is still readable and accessible; a deleted skill is gone.

### Onboarding new team members

1. Clone the repo (5 minutes)
2. Read README.md (2 minutes)
3. Read the pod CLAUDE.md for their domain (5 minutes)
4. Run 3 test prompts from `evals/` for the skills they'll use (10 minutes)

That's it. New team members contribute by opening a PR when they find a skill that could be improved.

---

## 11. Optional: GBrain Integration

GBrain (github.com/garrytan/gbrain) is a personal knowledge brain — a graph of pages connected by links and timelines, indexed for semantic search, accessible by agents via MCP or CLI.

This section explains how to integrate skills-hub with GBrain if you choose to add it. GBrain is not required to use skills-hub.

### Division of labor

GBrain owns brain primitives:
- Ingesting meeting transcripts → creating structured meeting pages with entity propagation
- Enriching entities (people, companies) → structured dossier pages with source attribution
- Maintaining the brain → cleaning dead links, rewriting compiled truth on pages with new evidence
- Querying the brain → semantic search, graph traversal, direct page lookup

Skills-hub owns workflows that USE the brain:
- Reading brain meeting pages to generate a leadership brief (cos-brief skill)
- Reading brain entity pages to generate a weekly synthesis (summary-brief skill)
- Logging a new deal to the brain after adding it to Airtable (deal-add skill → brain write)

The boundary: if GBrain has a built-in skill for it (ingest, enrich, maintain, query), don't rebuild it in skills-hub. Route to GBrain directly.

### Brain-first lookup pattern

Before a skill calls any external API to research a person, company, or topic, it should check the brain first:

```
If GBrain MCP is available:
  1. search "[name]" — keyword search
  2. query "[natural language question]" — hybrid search
  3. get <slug> — if you know the slug
  4. get_backlinks <slug> — who references this entity?
  Result: use brain context to inform the skill's output

If GBrain MCP is not available:
  Proceed without brain context. Note this in the output if relevant.
```

This pattern makes GBrain integration optional — skills work in both environments.

### Adding optional GBrain calls to a skill

**Without GBrain** — a skill that reviews a proposal starts from scratch every time:
```
Step 1 — Read the proposal
Step 2 — Identify the author and audience
Step 3 — Apply review criteria
```

**With GBrain** — the same skill gains context from the brain:
```
Step 0 — Brain lookup (if GBrain MCP available)
  gbrain search "[author name]" → read existing page if found
  Note: past review patterns for this author, recurring gaps, stated preferences
  Proceed with enriched context

Step 1 — Read the proposal
Step 2 — Identify the author and audience
Step 3 — Apply review criteria, informed by Step 0 patterns
Step 4 (after) — Update author's brain page: "2026-05-01: reviewed Q2 proposal, recurring gap: no clear ask"
```

In SKILL.md, add the conditional step like this:

```markdown
### Step 0 — Brain lookup (if GBrain MCP available)

Before starting, check the brain for existing context:

1. `gbrain search "[person or company name]"` — retrieve existing brain pages
2. If a brain page exists, note: last interaction, recurring patterns, open threads
3. After the skill completes, update the brain page with any new observations

If GBrain MCP is not available, skip this step and proceed from Step 1.
```

### Skills that chain with GBrain

| Skills-hub skill | GBrain integration |
|-----------------|-------------------|
| deal-add | After logging to Airtable → write `brain/deals/<slug>.md` and `brain/companies/<slug>.md` |
| document-review | Read brain page for author context before reviewing → note patterns in brain page after |
| Any skill involving a known person/company | Brain-first lookup before execution |

### Meeting ingestion

For meeting transcripts, route directly to GBrain's meeting-ingestion skill — don't rebuild it in skills-hub. GBrain handles attendee enrichment, entity propagation, timeline merge, and action item extraction. Skills-hub reads the resulting brain pages to generate summaries or track commitments.

### When to fork GBrain vs. use it as a dependency

**Use as a dependency** (most cases): your skills read from and write to GBrain pages. GBrain handles the brain; skills-hub handles the workflows.

**Fork GBrain** when: you need a custom MCP directory structure for your domain (VC: `people/`, `deals/`, `portcos/`; clinical: `patients/`, `studies/`, `protocols/`), or when you want to strip skills you don't need (media-ingest, social-ingest) and add domain-specific enrichment skills.

---

## 12. Optional: n8n Automation

n8n is an open-source workflow automation tool. It pairs well with skills-hub for tasks that need deterministic triggering (crons, webhooks, event-based) with agent-quality execution.

### When n8n makes sense

- Time-triggered summaries (Monday morning brief, weekly metrics digest)
- Event-triggered processing (new Airtable row, Circleback webhook, Slack message)
- Multi-step pipelines where Claude is one step among many (pull data → Claude summary → post to Slack)

### How skills-hub and n8n connect

n8n can invoke Claude via HTTP node (Anthropic API directly) or via the Claude node if available. The system prompt for that node can reference a skill or contain the skill content directly.

Pattern A — Reference the skill repo:
```
System: You are [Company Name]'s AI team. Follow the instructions in [SKILL.md content pasted here].
```

Pattern B — NanoClaw with n8n trigger:
n8n sends a webhook to NanoClaw → NanoClaw reads the skill from the repo → executes → returns structured output → n8n continues the workflow.

### The automation-architect skill (S-006)

When you're deciding whether to automate something with n8n, run S-006 first. It classifies your task into 5 levels and recommends the right approach with build effort estimates.

---

## 13. Skill Development Cycle

The 5-step cycle for building production-quality skills. Don't shortcut: a skill in production is code that runs on everything your team asks Claude to do.

### Step 1 — Concept

Identify the repeating task. Write down:
- What's the input? (what does a user provide)
- What's the output? (what do they get)
- What are the trigger phrases? (what would someone say to request this)
- How often does it run? (daily? weekly? ad hoc?)
- Who uses it? (which team member, in which environment)

If you can't answer all five, the skill isn't ready to build yet.

### Step 2 — Prototype

Write the SKILL.md. Follow the structure in §7. Start with the output format — work backwards from what you want to produce to the steps required to produce it.

Don't aim for completeness in the first draft. Aim for a skill that produces correct output on the 3 most common inputs.

### Step 3 — Evaluate

Write 3+ test prompts in `evals/evals.json`. Run each one. Grade the output 1-5 on these dimensions:

- **Specificity**: does the output use your company context, not generic defaults?
- **Correctness**: does it follow the skill's steps and produce the specified output format?
- **Completeness**: are all required sections present?
- **Conciseness**: is there filler, hedging, or padding that could be cut?

Target: 4/5 on all dimensions before marking `live`. If you're at 3/5, add more detail to the failing step or output format section.

### Step 4 — Codify

When the skill passes evals:
1. Set `status: live` in REGISTRY.md
2. Submit PR with the checklist from CONTRIBUTING.md
3. Assign an owner in REGISTRY.md

The skill is now in production. Team members can use it. Any subsequent changes go through the PR process.

### Step 5 — Cron (optional)

If the skill should run on a schedule (weekly brief, daily metrics, monthly report):
1. Evaluate using S-006 (automation-architect) whether cron is the right pattern
2. If yes: build an n8n workflow or NanoClaw cron job that invokes the skill
3. Add the automation to REGISTRY.md as `N-NNN`

Don't cron a skill that isn't stable. Run it manually 5+ times first. Automated output has no human in the loop to catch errors.

---

## 14. Registry & Governance

### ID format

- `S-NNN` — skills (SKILL.md files)
- `A-NNN` — agents (standalone agent definitions)
- `N-NNN` — automations (n8n workflows, cron jobs)

IDs are sequential and permanent. S-001 is always the first skill ever added, even if it's deprecated. Never reuse an ID.

### Status lifecycle

```
planned → draft → live → deprecated
```

- **planned**: in REGISTRY.md, not built yet. Tells the team not to duplicate work.
- **draft**: built, being tested. Not in the pod CLAUDE.md yet (Claude won't route to it).
- **live**: tested, in production. In the pod CLAUDE.md. Claude routes to it.
- **deprecated**: no longer maintained. In `_deprecated/`. Claude doesn't route to it.

### CI check

`.github/workflows/registry-check.yml` runs on every PR that touches REGISTRY.md or pods/. It checks:
- No duplicate IDs
- Every skill listed in REGISTRY.md has a corresponding SKILL.md file
- No stale references

This prevents the most common registry corruption: two people independently assign the same ID, or someone moves a skill directory without updating the registry.

### CI enforcement

`.github/workflows/registry-check.yml` runs automatically on every PR that touches REGISTRY.md or pods/. It catches two failure modes:

1. **Duplicate IDs** — two skills assigned the same S-NNN. Happens when two people independently add a skill and pick the same next ID.
2. **Dead paths** — a skill is listed in REGISTRY.md with `status: live` or `draft` but has no SKILL.md file on disk. Happens when someone moves a directory without updating the registry.

Run the check locally before opening a PR: `bash scripts/check-registry.sh`.

### CHANGELOG discipline

Every skill add or modification requires a CHANGELOG.md entry. The entry format:
```
[YYYY-MM-DD] Action: description (S-NNN)
```

Examples:
```
[2026-04-23] Add: design-brief — produces website briefs for product launches (S-001)
[2026-05-15] Update: brief-review — add Engineering perspective to multi-perspective review (S-002)
[2026-06-01] Deprecate: web-scraper — superseded by S-012 (competitor-analysis) (S-008)
```

The changelog is the audit trail. Don't skip it.

---

## 15. Appendix

### CLAUDE.md template (blank)

```markdown
# [COMPANY NAME] Skills Hub

## Your company

| Field | Value |
|-------|-------|
| Company | [Company name] |
| What you do | [One sentence] |
| Stage | [Pre-seed / Seed / Series A] |
| Team size | [N people] |
| Target audience | [Specific] |
| Current priority | [This month] |

## How this works

Skills are organized into pods. When a user makes a request:
1. Match to the right pod
2. Load the pod's CLAUDE.md
3. Execute the skill's SKILL.md

## Pod index

### [pod-name]
[Pod description]

| Skill | Status | Trigger |
|-------|--------|---------|
| skill-name | live | trigger keywords |

## Agent behaviour

After making any file changes, commit and push without asking. Update CHANGELOG.md and REGISTRY.md when adding or modifying skills.
```

---

### SKILL.md template (blank)

```yaml
---
name: skill-name
description: >
  What this skill does and when Claude should invoke it. Include natural
  language trigger phrases a user would actually say.
---
```

```markdown
# [Skill Name]

[2-3 sentences: what this skill produces, who uses it, what decision it informs.]

## When to use

[Explicit inclusion/exclusion rules. When to use. When NOT to use.]

## Instructions

### Step 1 — [Name]

[Instructions. Imperative form. Explain WHY.]

### Step 2 — [Name]

[Instructions.]

## Output format

[Structural skeleton or template the output must follow.]

## Examples

**Input:** [Realistic prompt a team member would type]

**Output:** (abbreviated) [What good output looks like]

## Dependencies

- [MCP, tool, or skill required]
- None (if no dependencies)
```

---

### Agent template (blank)

```markdown
---
name: agent-name
description: >
  What this agent does, when to spawn it, and what it returns.
runtime: claude-code | nanoclaw
model: claude-sonnet-4-6 | claude-opus-4-7
---

# [Agent Name]

[2-3 sentences: purpose, when to use, autonomy level.]

## Triggers

- [Condition that spawns this agent]

## Inputs

- [What the agent receives: file paths, URLs, structured data]

## Workflow

1. [Step 1]
2. [Step 2]
3. [Return result to parent]

## Output

[What the agent returns: file, structured data, summary]

## Skills used

- S-NNN (skill-name) — [how it's used]

## Autonomy boundaries

**May do without confirmation:** [list of actions]
**Must confirm before:** [list of risky actions]
```

---

### Trigger keyword quick reference

When writing a skill's description field, include the natural language phrases a user would say. Examples by pod:

| Pod | Natural trigger phrases |
|-----|------------------------|
| growth | "website brief", "landing page", "brief for [company]", "launch page", "waitlist page", "design brief" |
| content | "review this", "check this before it goes out", "edit this proposal", "co-author", "write a report" |
| engineering | "review this code", "check before deploy", "frontend QA", "accessibility check", "performance review" |
| infra | "automate this", "should this be a workflow", "which tool", "build a new skill", "add a role" |

---

### Registry entry format

```markdown
| S-008 | skill-name | pod-name | live | all | @owner | pods/pod-name/skill-name/SKILL.md | S-001 (if depends on) | One-sentence description |
```

Required columns: ID, Name, Pod, Status, Runtime, Owner, Path, Dependencies, Description.

If no dependencies: write `None`.
If no owner yet: write `—`.
