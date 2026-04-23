# Skills Hub

If you use Claude, you are already building skills — prompts that work, processes you have refined, instructions you paste at the start of sessions. The problem is not that you lack them. The problem is what happens when they pile up without a system.

They scatter across sessions that expire. Two team members write different versions of the same process. Claude loads whichever it finds first and averages them. Nobody knows what exists, what is current, what contradicts what. The more skills you build, the worse it gets.

A skills repo prevents that. One folder, version-controlled, organized by domain. Every skill has one canonical version. Claude reads the repo and routes to the right one automatically. When someone improves a skill, every future session uses the improved version. When someone leaves, the knowledge stays.

This template ships four roles as a starting point. You will add your own.

| Role | What it does | Trigger |
|------|-------------|---------|
| Growth Designer | Website and landing page briefs — audience, copy, hierarchy, technical spec | "Put together a website brief for..." |
| Brief QA | Reviews briefs before development. Severity-graded findings with fixes. | "Review this brief before we build" |
| Builder | Takes a brief, ships a complete website — HTML/CSS/JS, responsive, accessible | "Build the website from this brief" |
| Code Reviewer | Frontend code review — accessibility, performance, design compliance | "Review this code before deploy" |
| Content QA | Reviews proposals, memos, updates against quality standards | "Check this before it goes out" |
| Automation Architect | Evaluates whether a task should be a skill, workflow, agent, or manual process | "Should I automate this?" |

No slash commands. Describe the task, Claude routes to the right role.

---

## Setup

Five minutes. No coding.

**1. Get the repo.**
```bash
git clone https://github.com/badideas-fund/skills-hub-template ~/Documents/skills-hub
```

Or download as zip and move to `~/Documents/skills-hub`.

**2. Fill in your company context.** Open `CLAUDE.md`. Replace every `[bracketed value]` in the company context table. Four lines. This is what makes every skill output specific to your company instead of generic.

**3. Connect.**
- **Claude Desktop** → folder icon → Select folder → navigate to `~/Documents/skills-hub` → new session → say "hi"
- **Claude Code** → `cd ~/Documents/skills-hub && claude`

Done. Every role in the repo is live.

---

## Adding skills

Four skills is enough to start. As your company grows, you will need skills for things only you do — investor updates in your format, onboarding for your product, sales prep with your pitch.

Create a folder under the relevant pod, add a `SKILL.md`, update `CLAUDE.md` to list it. `CONTRIBUTING.md` has the full guide. `docs/SKILLPACK.md` has the architecture reference.

---

## Structure

```
CLAUDE.md              ← Company context + routing rules (edit first)
REGISTRY.md            ← Full inventory: every skill, agent, automation
ROADMAP.md             ← What to build, priority, status
CONTRIBUTING.md        ← How to add, modify, review skills
docs/
├── SKILLPACK.md       ← Complete architecture reference (read this)
├── getting-started.md ← Setup for Claude Desktop, Claude Code, NanoClaw
├── style-guide.md     ← Writing standards (customize for your voice)
├── architecture.md    ← How the router and pods work
├── automation-rule.md ← When to build a skill vs. workflow vs. agent
└── feedback-protocol.md ← How to log bugs and requests
pods/
├── growth/            ← Website briefs, builds, landing pages
├── content/           ← Document review, co-writing
├── engineering/       ← Code review, technical QA
└── infra/             ← Automation decisions, skill building
templates/
├── skill-template/    ← Starter template for new skills
└── agent-template.md  ← Starter template for new agents
logs/
└── feedback.json      ← Bug and feedback log (written by Claude)
```

---

## Credits

Built by [BADideas.fund](https://badideas.fund). Pre-seed fund, run by founders, built this for our own team first. Packaged it because every company we back hits the same problem by month three: skills accumulate without a system, and the drag exceeds the benefit.
