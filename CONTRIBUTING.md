# Contributing

How to add, modify, and review skills in this skills hub.

---

## Before you start

Read REGISTRY.md to see what already exists. If a skill covers your use case (even partially), extend it rather than creating a duplicate. If you're unsure, open an issue describing what you need — someone may already be working on it.

---

## Adding a new skill

### Step 1: Check the roadmap

Look at ROADMAP.md. If the skill is already listed, assign yourself as owner. If it's not listed, add it to the backlog first.

### Step 2: Identify the pod

Every skill belongs to a pod. Check the pod index in CLAUDE.md. If the skill doesn't fit any existing pod, propose a new pod in the PR.

### Step 3: Create the skill directory

```
pods/[pod-name]/[skill-name]/
├── SKILL.md           ← Required. Under 500 lines.
├── references/        ← Optional. Detailed docs, loaded on demand.
├── scripts/           ← Optional. Helper scripts invoked by the skill.
└── evals/             ← Optional. Test prompts and expected outputs.
    └── evals.json
```

SKILL.md must include YAML frontmatter at the top:

```yaml
---
name: skill-name
description: >
  What this skill does and when to use it. Be specific about trigger
  conditions — Claude tends to under-trigger skills. Include keywords
  a user would naturally say when they want this done.
---
```

### Step 4: Write the SKILL.md

Follow these principles (full guide in `docs/style-guide.md`):

1. **Explain why, not just what.** Claude adapts better when it understands the reasoning behind a step, not just the rule.
2. **Keep it under 500 lines.** Move reference material to `references/`. Every token competes with conversation history.
3. **Include examples.** At least one realistic input/output example showing what good looks like.
4. **Specify dependencies.** If the skill needs an MCP server, API key, or specific tool, say so at the top.
5. **Define the output.** What does the user get? A file? A structured report? A decision? Be explicit about the format.

### Step 5: Test it

Write 2-3 realistic test prompts in `evals/evals.json`:

```json
{
  "skill_name": "your-skill",
  "evals": [
    {
      "id": 1,
      "prompt": "A realistic thing a team member would actually say",
      "expected_output": "Description of what the skill should produce"
    }
  ]
}
```

Run the skill against each prompt. Confirm the output matches what you'd want a teammate to deliver.

### Step 6: Submit a PR

The PR must include:

1. The skill directory inside the correct pod
2. Updated REGISTRY.md with a new row (next available ID)
3. Updated pod CLAUDE.md listing the new skill
4. Updated CHANGELOG.md with an entry under `[Unreleased]`
5. At least one test prompt in the PR description showing the skill works

---

## Modifying an existing skill

1. Read the current SKILL.md and understand its intent.
2. Make changes. If substantive (new steps, changed behavior), re-run the test prompts from `evals/`.
3. Submit a PR. Tag the skill's owner (from REGISTRY.md) as reviewer.
4. Update CHANGELOG.md.

---

## Review process

Every PR that adds or modifies a skill gets reviewed by one person:

- Same domain: the skill's owner reviews, or another person in that domain.
- Cross-domain or infra: the platform maintainer reviews.

Review checklist:

- [ ] SKILL.md is under 500 lines
- [ ] Description in frontmatter clearly states when to trigger
- [ ] Dependencies listed (MCPs, APIs, tools)
- [ ] At least one test prompt exists in `evals/`
- [ ] REGISTRY.md updated
- [ ] Pod CLAUDE.md updated
- [ ] CHANGELOG.md updated
- [ ] No secrets, API keys, or credentials in any skill file

---

## Naming conventions

- Skill directories: lowercase, hyphenated. `competitor-analysis`, not `CompetitorAnalysis`.
- Agent files: lowercase, hyphenated, `.md` extension. `deal-screener.md`.
- IDs: `S-NNN` for skills, `A-NNN` for agents, `N-NNN` for automations. Sequential, never reused.

---

## Changing or deprecating a skill

**Minor edits** (typos, clarifying wording, adding an example): open a PR, tag the skill owner. No discussion period. Merge on one approval.

**Behavioral changes** (new steps, changed output format, different trigger conditions): open a PR with a description of what changes and why. Tag the skill owner and anyone who uses it regularly. PR stays open for 48 hours before merging.

**Deprecation**: no skill is ever deleted. The process:
1. Open an issue titled `Deprecate S-NNN [skill-name]` with the reason.
2. Issue stays open for one week. Anyone using the skill can object.
3. If no objection: change status to `deprecated` in REGISTRY.md, add a note pointing to the replacement, move directory to `_deprecated/`. Update CHANGELOG.md.
4. The `_deprecated/` folder is never cleaned out — old skills stay permanently accessible.

---

## Versioning

Skills don't have version numbers. Git history is the version history. If a behavioral change is large enough that existing users need to adapt (output format changes, a step removed), the PR description must include a migration note: what changed, why, what to do differently.

**Branch protection:** main requires one PR approval before merge. No direct pushes. This keeps all changes visible.
