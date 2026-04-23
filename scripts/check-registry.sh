#!/bin/bash
# Checks REGISTRY.md for duplicate skill IDs (S-NNN, A-NNN, N-NNN).
# Run locally before opening a PR, or automatically via CI.
# Exit 1 if duplicates found, 0 if clean.

set -euo pipefail

REGISTRY="${1:-REGISTRY.md}"

if [ ! -f "$REGISTRY" ]; then
  echo "ERROR: $REGISTRY not found"
  exit 1
fi

# Extract all IDs — match table rows starting with | S-, | A-, | N-
ids=$(grep -E '^\| [SAN]-[0-9]+' "$REGISTRY" | awk -F'|' '{print $2}' | tr -d ' ')

if [ -z "$ids" ]; then
  echo "No skill IDs found in $REGISTRY — check the format."
  exit 1
fi

duplicates=$(echo "$ids" | sort | uniq -d)

if [ -n "$duplicates" ]; then
  echo ""
  echo "REGISTRY CHECK FAILED: duplicate skill IDs detected"
  echo "────────────────────────────────────────────────────"
  for id in $duplicates; do
    echo "  $id appears $(echo "$ids" | grep -c "^${id}$") times:"
    grep -n "| $id " "$REGISTRY" | while IFS= read -r line; do
      echo "    line $line"
    done
  done
  echo ""
  echo "Fix: assign the next available ID from the bottom of REGISTRY.md."
  echo "Current highest IDs:"
  echo "$ids" | sort -t'-' -k1,1 -k2,2n | tail -6
  exit 1
fi

# Check that live/draft skills actually have a SKILL.md on disk (planned = not yet built, skip)
echo "Checking skill file paths for live/draft skills..."
missing=0
while IFS='|' read -r _ id name pod status runtime source owner path deps desc _; do
  id=$(echo "$id" | tr -d ' ')
  status=$(echo "$status" | tr -d ' ')
  path=$(echo "$path" | tr -d ' ')
  [[ "$id" =~ ^[SAN]-[0-9]+$ ]] || continue
  [[ "$status" == "live" || "$status" == "draft" ]] || continue
  [[ "$path" == pods/* ]] || continue
  if [[ "$path" == *.md ]]; then
    skill_file="$path"
  else
    skill_file="$path/SKILL.md"
  fi
  if [ ! -f "$skill_file" ]; then
    echo "  MISSING: $id ($name, $status) — no skill file at $skill_file"
    missing=$((missing + 1))
  fi
done < "$REGISTRY"

if [ "$missing" -gt 0 ]; then
  echo ""
  echo "REGISTRY CHECK FAILED: $missing skill(s) listed in REGISTRY have no SKILL.md on disk."
  echo "Either create the file or remove the registry entry."
  exit 1
fi

total=$(echo "$ids" | wc -l | tr -d ' ')
echo "Registry check passed: $total skills, no duplicate IDs, all paths valid."
