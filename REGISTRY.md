# Registry

Complete inventory of skills, agents, and automations. Every skill gets an ID. IDs are never reused.

Format: `S-NNN` (skills), `A-NNN` (agents), `N-NNN` (automations).

Status lifecycle: `planned` → `draft` → `live` → `deprecated`.

---

## Skills

| ID | Name | Pod | Status | Runtime | Owner | Path | Dependencies | Description |
|----|------|-----|--------|---------|-------|------|-------------|-------------|
| S-001 | design-brief | growth | live | all | — | pods/growth/design-brief/SKILL.md | web search (optional) | Produces website/landing page design briefs |
| S-002 | brief-review | growth | live | all | — | pods/growth/brief-review/SKILL.md | web fetch (optional) | Reviews briefs before development; severity-graded |
| S-003 | web-pipeline | growth | live | all | — | pods/growth/web-pipeline/SKILL.md | None | Builds complete websites from a brief |
| S-004 | document-review | content | live | all | — | pods/content/document-review/SKILL.md | None | Reviews documents against quality standards |
| S-005 | frontend-review | engineering | live | all | — | pods/engineering/frontend-review/SKILL.md | None | Code review: accessibility, performance, design |
| S-006 | automation-architect | infra | live | all | — | pods/infra/automation-architect/SKILL.md | None | Evaluates what type of automation to build |
| S-007 | skill-builder | infra | live | all | — | pods/infra/skill-builder/SKILL.md | None | Guides creation of new skills in this repo |

## Agents

| ID | Name | Pod | Status | Runtime | Owner | Path | Description |
|----|------|-----|--------|---------|-------|------|-------------|
| A-001 | *your-first-agent* | — | planned | — | — | — | Add your first agent here |

## Automations

| ID | Name | Pod | Status | Runtime | Owner | Path | Description |
|----|------|-----|--------|---------|-------|------|-------------|
| N-001 | *your-first-automation* | — | planned | — | — | — | Add your first automation here |

---

## How to add a row

1. Assign the next available ID (check last entry in each table).
2. Fill in all columns. No blank required fields.
3. Set status to `draft` until tested, then `live`.
4. Update the pod's CLAUDE.md to list the skill.
5. Update CHANGELOG.md.

IDs are permanent. If a skill is deprecated, keep its row with `status: deprecated` and add a note in the Description column pointing to the replacement.
