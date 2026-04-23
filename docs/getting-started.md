# Getting Started

How to connect Claude to your skills hub.

---

## What this is

A GitHub repo that makes Claude better at your company's specific work. When Claude can see this repo, it routes your requests to the right skill automatically. No slash commands, no skill IDs — describe what you need.

---

## Setup: Claude Desktop (recommended for most users)

**One-time setup (5 minutes):**

1. Clone or download the repo:
   ```bash
   git clone https://github.com/YOUR-ORG/YOUR-REPO ~/Documents/skills-hub
   ```

2. Fill in your company context: open `CLAUDE.md`, replace every `[bracketed value]` in the company table.

3. Open Claude desktop app → folder icon (or Cowork tab) → **Select folder** → navigate to `~/Documents/skills-hub` → select it.

4. Start a new session → say "hi" to confirm it loaded.

**Using it:** Open a new session. Describe your task naturally. Examples:

- "Put together a website brief for our launch" → runs design-brief (S-001)
- "Review this proposal before it goes out" → runs document-review (S-004)
- "Should I automate this task?" → runs automation-architect (S-006)

---

## Setup: Claude Code

For technical users who prefer the terminal or want to commit files directly.

```bash
git clone https://github.com/YOUR-ORG/YOUR-REPO ~/Documents/skills-hub
cd ~/Documents/skills-hub
claude
```

Root `CLAUDE.md` loads automatically. All skills are available. Skills that write files (briefs, specs, reports) will save them into the repo and can commit them.

---

## Setup: NanoClaw (container)

For teams running NanoClaw (container-hosted Claude with long-running sessions and MCPs):

1. Mount the skills-hub repo as a volume in your NanoClaw container
2. Set the working directory to the repo root
3. Skills tagged `all` in REGISTRY.md work out of the box
4. Skills tagged `nanoclaw` require additional tools configured at container startup

---

## Pulling updates

When someone on your team improves a skill and pushes to main:

```bash
cd ~/Documents/skills-hub
git pull
```

Then start a **new** session — existing sessions don't reload file changes.

---

## Filing bugs and feedback

If a skill produces wrong output or triggers on the wrong request:

1. Tell Claude: `"feedback: [describe what happened]"` — it logs automatically to `logs/feedback.json`
2. Or open a GitHub issue tagging the skill's owner (see REGISTRY.md for ownership)

---

## Adding a skill

See CONTRIBUTING.md for the full process. Short version:

1. Check REGISTRY.md for the next available ID (S-NNN)
2. Create `pods/[pod-name]/[skill-name]/SKILL.md` following `templates/skill-template/SKILL.md`
3. Add the row to REGISTRY.md
4. Update the pod's CLAUDE.md
5. Update CHANGELOG.md
6. Open a PR

The dashboard (`dashboard.html`, open in any browser) shows what's live, what's coming, and recent feedback.
