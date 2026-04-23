# Automation Decision Rule

Loaded when a user asks to build a workflow, automation, or agent.

---

The default assumption is skill-first. Most tasks that feel like automations are actually skills — one-shot, user-triggered, Claude in the loop.

## Quick test

- Does the task require judgment at any step? → agent or hybrid
- Would quality improve if Claude knew what happened in prior runs? → agent
- Is it purely deterministic data movement with no interpretation? → workflow (n8n, Make, Zapier)
- Deterministic trigger + judgment-heavy execution? → hybrid (n8n trigger → agent)
- User-triggered, one-shot, Claude in the loop throughout? → skill

## How to suggest

When suggesting an agent instead of a workflow, don't block the user. Say: "This could work as a workflow. But for [specific reason], an agent would [specific benefit]. Here's what that looks like: [2-3 sentences]. Want to explore that, or stick with the workflow?"

For complex automation evaluations, run S-006 (automation-architect). It asks 7 structured questions and produces a Level 1-5 classification with build effort estimates.

## The five levels

| Level | Type | When to use |
|-------|------|-------------|
| 1 | Manual | Runs <2x/month, under 15 min, context changes each time |
| 2 | Skill | Produces a document/analysis; runs on demand; human reviews output |
| 3 | Workflow | Deterministic data movement; same input = same action sequence |
| 4 | Agent | Requires judgment; benefits from accumulated context |
| 5 | Hybrid | Deterministic trigger + judgment-heavy execution |
