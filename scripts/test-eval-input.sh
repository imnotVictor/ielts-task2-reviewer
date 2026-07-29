#!/bin/sh

set -eu

rendered="$(mktemp)"

./scripts/run-prompt-evals.sh \
  --render-input \
  en \
  "$PWD/evals/cases/01-off-topic.md" \
  "$rendered"

rg -q '^## Task 2 question$' "$rendered"
rg -q '^## Student essay$' "$rendered"

if rg -q '^## Evaluation target$|^Primary weakness:|^Available evidence anchors:' "$rendered"; then
  echo "Rendered model input leaked evaluation metadata" >&2
  exit 1
fi

echo "Evaluation input isolation passed."
