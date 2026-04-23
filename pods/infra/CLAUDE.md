# Infra Pod

Platform infrastructure: automation decisions and skill building. Use for any request mentioning: automate this, should this be a workflow or agent, build a new skill, add a role, teach Claude how to do X, what's the right tool for this, I want to automate.

## Skills

| Skill | Status | Trigger |
|-------|--------|---------|
| automation-architect | live | "automate this", "should I use n8n or an agent", "which tool should I use", "should this be a workflow" |
| skill-builder | live | "build a new skill", "add a role", "teach Claude how to do X", "add a new capability" |

## Standards

automation-architect gate: no automation gets built without going through S-006 (automation-architect) first. This prevents teams from defaulting to workflows when an agent would produce better results, or defaulting to agents when a simple workflow covers the case.

skill-builder output: every skill produced by S-007 must include YAML frontmatter, at least 2 instruction steps with WHY not just WHAT, an output format section with a structural skeleton, and at least one example. It must be under 500 lines.

Meta-skills: infra skills teach the system to build more skills. The quality bar is higher — these are the skills that produce other skills, so errors here compound.
