#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
output_root="$repo_root/.eval-output"

run_one() {
  local language="$1"
  local case_path="$2"
  local case_name
  local prompt_path
  local input_path
  local output_path
  local log_path

  case_name="$(basename "$case_path" .md)"
  prompt_path="$repo_root/prompts/task2-reviewer-${language}.md"
  input_path="$output_root/${case_name}-${language}.input.md"
  output_path="$output_root/${case_name}-${language}.output.md"
  log_path="$output_root/${case_name}-${language}.log"

  {
    sed -n '/^```text$/,/^```$/p' "$prompt_path"
    printf '\nUSER SUBMISSION\n'
    cat "$case_path"
  } > "$input_path"

  codex exec \
    --ephemeral \
    --ignore-user-config \
    -s read-only \
    -C "$repo_root" \
    -o "$output_path" \
    - < "$input_path" > "$log_path" 2>&1

  printf 'completed %s %s\n' "$language" "$case_name"
}

mkdir -p "$output_root"

if [ "${1:-}" = "--one" ]; then
  run_one "$2" "$3"
  exit 0
fi

job_file="$output_root/jobs.txt"
: > "$job_file"
for language in en zh; do
  for case_path in "$repo_root"/evals/cases/*.md; do
    printf '%s\0%s\0' "$language" "$case_path" >> "$job_file"
  done
done

xargs -0 -n 2 -P 4 "$0" --one < "$job_file"
