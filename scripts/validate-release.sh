#!/bin/sh

set -eu

phase="${2:-}"
if [ "${1:-}" != "--phase" ] || { [ "$phase" != "scaffold" ] && [ "$phase" != "full" ]; }; then
  echo "Usage: $0 --phase scaffold|full" >&2
  exit 2
fi

required_scaffold="
README.md
README.zh-CN.md
LICENSE.md
CHANGELOG.md
VERSION
scripts/validate-release.sh
"

required_full="
prompts/task2-reviewer-en.md
prompts/task2-reviewer-zh.md
codex-skill/ielts-task2-reviewer/SKILL.md
codex-skill/ielts-task2-reviewer/references/scoring-output-format.md
examples/sample-essay.md
examples/sample-review.md
docs/quick-start.md
docs/scoring-disclaimer.md
docs/full-version.md
evals/evaluation-rubric.md
evals/run-log.md
"

missing=0
for path in $required_scaffold; do
  if [ ! -f "$path" ]; then
    echo "Missing required file: $path" >&2
    missing=1
  fi
done

if [ "$phase" = "full" ]; then
  for path in $required_full; do
    if [ ! -f "$path" ]; then
      echo "Missing required file: $path" >&2
      missing=1
    fi
  done

  case_count="$(find evals/cases -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$case_count" -ne 10 ]; then
    echo "Expected 10 evaluation cases, found $case_count" >&2
    missing=1
  fi
fi

if [ -f VERSION ] && [ "$(tr -d '\r\n' < VERSION)" != "1.0.0" ]; then
  echo "VERSION must contain exactly 1.0.0" >&2
  missing=1
fi

if [ -f README.md ]; then
  rg -qi "unlimited use" README.md || {
    echo "README.md must state unlimited use" >&2
    missing=1
  }
  rg -qi "training reference score" README.md || {
    echo "README.md must use training reference score wording" >&2
    missing=1
  }
  rg -qi "individual non-commercial" README.md || {
    echo "README.md must summarize the individual non-commercial license" >&2
    missing=1
  }
fi

if [ -f README.zh-CN.md ]; then
  rg -q "不限使用次数" README.zh-CN.md || {
    echo "README.zh-CN.md must state unlimited use" >&2
    missing=1
  }
  rg -q "训练参考分" README.zh-CN.md || {
    echo "README.zh-CN.md must use training reference score wording" >&2
    missing=1
  }
  rg -q "个人非商业使用" README.zh-CN.md || {
    echo "README.zh-CN.md must summarize the individual non-commercial license" >&2
    missing=1
  }
fi

for forbidden_name in weekly-review notion-template error-card-generator paid; do
  if find . -path './.git' -prune -o -type f -iname "*${forbidden_name}*" -print | rg -q .; then
    echo "Forbidden premium filename found: $forbidden_name" >&2
    missing=1
  fi
done

if rg -n -i --hidden -g '!.git/**' -g '!scripts/validate-release.sh' \
  -e 'API_KEY' -e 'sk-' -e 'checkout_secret' -e 'private_contact' . >/dev/null 2>&1; then
  echo "Potential secret marker found" >&2
  missing=1
fi

if [ "$missing" -ne 0 ]; then
  exit 1
fi

echo "Release validation passed for phase: $phase"
