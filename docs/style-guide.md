# Style Guide

Writing standards for skills, agents, and documents in this skills hub.

Customize the **Voice** section for your company. The structural standards below apply to all teams.

---

## Voice

Write like an internal memo: high information density, low rhetoric.

Constraints (non-negotiable):

- No superlatives. Avoid "largest," "most," "uniquely," "powerful," "transformative," "best-in-class."
- No slogans, motivational framing, or validation ("great question," "absolutely").
- No metaphors or literary framing.
- No consultant voice ("key takeaway," "unlock," "levers," "game-changer").
- Short sentences with concrete nouns and verbs.

**[ADD YOUR COMPANY'S VOICE HERE]**

Examples of what to customize:
- Formality level (we vs. I, formal vs. casual)
- Jargon that's acceptable vs. not
- Tone for external communications (investor updates, customer emails)
- Specific phrases to avoid

---

## Skill structure

Every SKILL.md follows this order:

```yaml
---
name: skill-name
description: What it does and when to trigger. Over-specify trigger conditions.
---
```

Then in the body:

1. **Purpose** (2-3 sentences). What this skill produces and who uses it.
2. **When to use** (optional). Explicit inclusion/exclusion rules.
3. **Instructions** (the core workflow). Imperative form. "Identify the target user" not "You should identify the target user."
4. **Output format** (what the user gets). Skeleton or template.
5. **Examples** (at least one realistic input/output pair).
6. **Dependencies** (MCPs, tools, other skills referenced by ID).

---

## What makes a good skill

**It answers "what decision does this inform?"** A skill that produces a document nobody acts on is busywork. Every skill output should feed a specific decision or deliverable.

**It explains why.** Instead of "ALWAYS use bottom-up TAM," write: "Use bottom-up TAM because top-down estimates systematically overcount. A $50B TAM with 0.01% capture is less useful than a $500M TAM with 5% capture and named buyers."

**It's testable.** Given a specific input, two people running the skill should produce structurally similar output. If the output depends entirely on Claude's judgment, the skill is underspecified.

**It stays under 500 lines.** If approaching this limit, move reference material to `references/` and add pointers: "For competitive positioning frameworks, read `references/positioning.md`."

---

## What makes a bad skill

**Scorecard without calibration.** A 1-5 scale across 7 dimensions that produces a score out of 35 is pseudo-rigorous. If you use scoring, define what 1 and 5 mean concretely for each dimension.

**Generic advice.** "Post on social media" or "try content marketing" is not a tactic. Name the specific channel, audience segment, keyword cluster.

**Templates without judgment.** A template that says "[fill in your target user]" is less useful than one that says: "Target user must be specific enough that you could find 10 of them on LinkedIn in 5 minutes. 'SMB owners' fails. 'Solo accountants in the US with 10-50 clients using QuickBooks' passes."

---

## Naming

- Skill names: lowercase, hyphenated, 2-3 words. `competitor-analysis` not `competitive-intelligence-deep-dive`.
- Reference files: lowercase, hyphenated. `positioning-frameworks.md`.
- Scripts: lowercase, hyphenated. `extract-metrics.py`.

---

## Evidence discipline

For every non-trivial claim in a skill output, anchor to one of:

1. A concrete fact (named source, specific number).
2. A quote or paraphrase from an authoritative source.
3. A numeric example or explicit mechanism.
4. A clearly labeled **Assumption** or **Inference**.

If a claim can't be anchored, don't include it. This applies especially to market size claims, user behavior assumptions, and competitive positioning statements.
