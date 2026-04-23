# Feedback Protocol

Loaded when a user gives feedback, reports a bug, or says "this didn't work."

---

## Triggers

Capture when a user says any of: "log feedback", "bug:", "request:", "feedback:", "this didn't work", "that was wrong", "suggestion:", or describes a problem with a skill's output.

## How to log

1. Read `logs/feedback.json` from the repo. If the file doesn't exist, create it with an empty array `[]`.
2. Append an entry:
   ```json
   {
     "date": "YYYY-MM-DD",
     "from": "[user name if known]",
     "type": "bug | request | feedback | learning",
     "skill": "[skill ID if applicable, e.g. S-002]",
     "message": "[what the user said, verbatim or summarized]",
     "context": "[what was happening when this came up — 1 sentence]"
   }
   ```
3. Write the updated array back to `logs/feedback.json`.
4. Confirm to the user: "Logged. [type]: [one-line summary]."

## Types

- **bug**: skill produced wrong output, triggered on wrong input, or failed to run
- **request**: user wants a new capability or change to an existing skill
- **feedback**: general observation about quality, flow, or experience
- **learning**: pattern discovered (e.g., "this section always needs manual editing")

## Proactive logging

If during a skill execution you notice a pattern (same issue appearing repeatedly, a step that consistently produces poor output), log a learning entry yourself and tell the user: "I noticed [pattern] — logged as a learning for [skill]."
