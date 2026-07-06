#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

missing=0

while IFS= read -r skill_dir; do
  skill_name="${skill_dir##*/}"
  metadata_file="$skill_dir/agents/openai.yaml"

  if [[ ! -f "$metadata_file" ]]; then
    echo "Missing OpenAI metadata policy for skill: $skill_name" >&2
    missing=1
    continue
  fi

  if ! grep -Eq '^[[:space:]]*policy:[[:space:]]*$' "$metadata_file"; then
    echo "Missing policy block in OpenAI metadata for skill: $skill_name" >&2
    missing=1
  fi

  if ! grep -Eq '^[[:space:]]+allow_implicit_invocation:[[:space:]]*false[[:space:]]*$' "$metadata_file"; then
    echo "Missing allow_implicit_invocation: false in OpenAI metadata for skill: $skill_name" >&2
    missing=1
  fi
done < <(find "$REPO_ROOT/skills" -mindepth 1 -maxdepth 1 -type d -print | sort)

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "Codex skill OpenAI invocation policy looks good"
