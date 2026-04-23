# Architecture

How the skills hub works internally.

---

## The routing system

```
CLAUDE.md (root router, ~100 lines)
    ↓ matches pod
pods/[pod-name]/CLAUDE.md (pod router, ~30-50 lines per pod)
    ↓ matches skill
pods/[pod-name]/[skill-name]/SKILL.md (execution, ≤500 lines)
    ↓ optional
pods/[pod-name]/[skill-name]/references/ (detail, loaded on demand)
```

CLAUDE.md is loaded on every session. It stays thin — company context table and pod index only. All intelligence is in the skills.

---

## Pod isolation

Each pod is self-contained. The pod's CLAUDE.md knows which skills it contains, when each triggers, and any pod-level conventions. You can rewrite an entire pod without touching any other pod.

Cross-pod work: Claude runs each pod's skill independently and routes intermediate output through the user. No pod assumes it knows the output format of another pod.

---

## Session context

Claude reads CLAUDE.md when:
- A new Claude Desktop session starts with the folder mounted
- A new Claude Code session starts in the repo's working directory
- A new NanoClaw session starts with the repo mounted

CLAUDE.md changes take effect in the next session. Editing a skill and immediately testing it requires starting a new session.

---

## Reference files

Skills that need detailed reference material (frameworks, datasets, long examples) put it in `references/` inside the skill directory:

```
pods/growth/design-brief/
├── SKILL.md                        ← core skill (≤500 lines)
└── references/
    ├── copy-frameworks.md          ← PAS, AIDA, BAB deep dives
    └── design-presets.md           ← Tailwind presets for each design style
```

SKILL.md includes a pointer: "For copy framework details, read `references/copy-frameworks.md`." Claude loads references on demand, not upfront. This keeps the main skill lean.

---

## Feedback loop

When a user says "feedback: [something]", Claude logs to `logs/feedback.json`. The dashboard (`dashboard.html`, open in any browser) reads this file and shows:
- Recent bugs, requests, and learnings
- Skill health by pod
- Contribution leaderboard

The feedback loop closes when someone reads the log and improves the skill.

---

## CI

`.github/workflows/registry-check.yml` runs on every PR touching REGISTRY.md or pods/. It checks:
- No duplicate IDs (two skills with the same S-NNN)
- Every skill in REGISTRY.md has a matching SKILL.md file

This prevents the most common failure: two people independently assign the same ID, or a skill is moved without updating the registry.

---

## What this is not

**Not a framework.** There's no code, no CLI, no build step. It's a folder with markdown files and a CI check.

**Not a prompt library.** Skills are not standalone prompts. They encode a workflow — multiple steps, output format, examples, dependencies. The difference: a prompt is a starting point; a skill is a process.

**Not version-pinned.** Skills don't have version numbers. Git history is the version history. Every commit is visible and revertible.
