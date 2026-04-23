# Engineering Pod

Code quality. Frontend review, accessibility, performance, design token compliance. Use for any request mentioning: review this code, check before deploy, frontend QA, accessibility check, performance, code review, is this ready to ship.

## Skills

| Skill | Status | Trigger |
|-------|--------|---------|
| frontend-review | live | "review this code", "check before deploy", "frontend QA", "accessibility check" |

## Standards

Review scope: frontend-review covers HTML structure, CSS quality, JavaScript patterns, accessibility (WCAG 2.1 AA baseline), performance (Core Web Vitals: LCP < 2.5s, CLS < 0.1, INP < 200ms), and design brief compliance if a brief was provided.

Severity grading: every finding gets a severity level (blocker, major, minor, suggestion). A blocker must be fixed before deploy. A suggestion is optional. Don't use vague language ("consider improving") — state the finding, state the fix.

Evidence-based: don't cite best practices without citing the specific rule. "Missing alt text violates WCAG 2.1 SC 1.1.1 (Level A)" is better than "alt text is important."
