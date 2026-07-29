#!/bin/sh

set -eu

fixture_root="$(mktemp -d)"
cp .eval-output/*.output.md "$fixture_root/"

target="$fixture_root/01-off-topic-en.output.md"
awk '
  /^## Scoring Limitation$/ && !inserted {
    print "## Revised Essay"
    print ""
    print "This paragraph represents an unauthorized replacement essay. It is intentionally repeated to simulate a long rewritten response that should never appear in the free reviewer output."
    print ""
    print "This second paragraph continues the replacement essay and demonstrates that a heading-based rewrite must be rejected even when all required review sections are also present."
    print ""
    inserted=1
  }
  { print }
' "$target" > "$target.tmp"
mv "$target.tmp" "$target"

if EVAL_OUTPUT_ROOT="$fixture_root" node scripts/check-prompt-evals.mjs > "$fixture_root/check.log" 2>&1; then
  echo "Checker accepted an unexpected rewritten-essay section" >&2
  exit 1
fi

if ! rg -q 'unexpected heading.*Revised Essay' "$fixture_root/check.log"; then
  echo "Checker failed for the wrong reason:" >&2
  cat "$fixture_root/check.log" >&2
  exit 1
fi

echo "Adversarial rewrite-heading detection passed."
