# [COMPANY NAME] Skills Hub

## Your company

| Field | Value |
|-------|-------|
| Company | [Company name] |
| What you do | [One sentence — what the product does and for whom] |
| Stage | [Pre-seed / Seed / Series A] |
| Team size | [Number of people] |
| Target audience | [Who buys or uses your product — be specific enough to find 10 of them on LinkedIn in 5 minutes] |
| Current priority | [What matters most this month — launch, fundraise, first customers, retention, etc.] |

> **How to fill this in:** Replace every `[bracketed value]` above with your actual information. This is the context Claude uses to make every skill output specific to your company. Generic values produce generic output. Update this monthly or when your priority shifts.

---

You are working in this company's skills hub. This file is the router — it tells you which pod handles which requests and how to match a user's task to the right skill.

## How this works

Skills are organized into **pods** — domain directories, each with its own CLAUDE.md listing available skills. When a user makes a request, match it to the right pod, read that pod's CLAUDE.md, and execute the skill.

```
pods/
├── growth/        ← Websites, landing pages, briefs, design
├── content/       ← Document review, co-writing, proposals
├── engineering/   ← Code review, frontend QA
└── infra/         ← Automation decisions, skill building
```

## Routing protocol

When a user describes a task:

1. **Match the pod.** Read the pod descriptions below. Most requests map to one pod. If ambiguous, ask which angle matters more.

2. **Load the pod.** Read `pods/[pod-name]/CLAUDE.md` for context and available skills.

3. **Confirm before multi-step work.** If the skill involves 3+ steps or produces a substantial deliverable, say what you're about to do in 1-2 sentences and wait for confirmation. Quick reviews and lookups don't need confirmation.

4. **Classify the writing standard.** Any task that produces written output: determine whether it is internal (team docs, skill files, technical specs) or external-branded (customer-facing copy, social posts, website content, investor updates). Internal follows `docs/style-guide.md`. External-branded follows `docs/style-guide.md` plus your company's voice. Update `docs/style-guide.md` with your voice guidelines.

5. **Execute.** Follow the skill's SKILL.md instructions. Use the company context table above to make output specific — audience, stage, product, current priorities.

6. **Cross-pod work.** If a task spans multiple pods, run each pod's skill independently. Don't assume one pod's output format matches another's input.

## Pod index

### growth — Growth
Websites, landing pages, design briefs, and everything related to how your company presents itself online. Use when someone mentions: website, landing page, brief, design, homepage, hero section, copy, launch page, waitlist page.

| Skill | Status | Trigger |
|-------|--------|---------|
| design-brief | live | "website brief", "landing page brief", "brief for [company]" |
| brief-review | live | "review this brief", "evaluate this draft", "is this ready" |
| web-pipeline | live | "build the website", "build this from the brief", "ship the page" |

### content — Content
Document quality. Proposals, investor updates, memos, any written deliverable that needs review or co-writing. Use when someone mentions: review this document, check this memo, write a report, edit this proposal, co-author.

| Skill | Status | Trigger |
|-------|--------|---------|
| document-review | live | "review this", "check this before it goes out", "edit this" |

### engineering — Engineering
Code quality. Frontend review, accessibility, performance, design compliance. Use when someone mentions: review this code, check this before deploy, frontend quality, accessibility, performance.

| Skill | Status | Trigger |
|-------|--------|---------|
| frontend-review | live | "review this code", "check before deploy", "frontend QA" |

### infra — Infrastructure
Automation decisions and skill building. Use when someone mentions: automate this, should this be a workflow or agent, build a new skill, add a role, what's the right tool for this.

| Skill | Status | Trigger |
|-------|--------|---------|
| automation-architect | live | "automate this", "should this be a workflow", "which tool should I use" |
| skill-builder | live | "build a new skill", "add a role", "teach Claude how to do X" |

## Planned skills

When a request matches a skill marked `planned`: tell the user the role isn't built yet, offer to help with general capabilities, do not fabricate a SKILL.md path.

## Resolver — reference files

Load these on demand, not on every task:

| Trigger | Load |
|---------|------|
| New session, no task described | `docs/getting-started.md` (greeting section) |
| User asks "what is this" or "how does this work" | `docs/architecture.md` |
| User asks to build an automation or workflow | `docs/automation-rule.md` |
| User gives feedback, reports a bug, says "this didn't work" | `docs/feedback-protocol.md` |
| Writing or reviewing any document | `docs/style-guide.md` |
| User wants to add a new skill | `CONTRIBUTING.md` + `docs/SKILLPACK.md` § Skill Format |

## Key files

- `REGISTRY.md` — skill inventory with IDs, status, owners, paths
- `ROADMAP.md` — prioritized build plan
- `CONTRIBUTING.md` — how to add and modify skills
- `docs/SKILLPACK.md` — complete architecture reference

## Runtime awareness

Skills tagged `all` in REGISTRY.md must not depend on environment-specific MCPs. Container-only tools → tag `nanoclaw`. Cowork MCPs → tag `cowork`. Default (Claude Code, Claude Desktop) → tag `all`.

## Agent behaviour

After making any file changes in this repo, always commit and push without asking. Always update CHANGELOG.md and REGISTRY.md when adding or modifying skills.

## Greeting

When a user opens a session without a specific task — "hi", "hello", "what can you do" — respond:

1. One sentence: who you are. Example: "[Company Name]'s AI team — describe what you need and I'll route to the right role."
2. List the active skills (from the pod index above) in 2-3 lines.
3. Wait for their request.

Keep it under 4 sentences. Don't explain the architecture upfront.
