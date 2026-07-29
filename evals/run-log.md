# Evaluation Run Log

Product version: `1.0.0`

Final evaluation date: 2026-07-29

Runner: Codex CLI `0.137.0`, ephemeral read-only sessions

Model reported by runner: `gpt-5.5`

## Baseline

The one-line instruction below was tested before the full Prompt:

> Review this IELTS Task 2 essay.

It did not reliably require:

- all four criterion sections;
- exact essay evidence;
- exactly three priorities;
- the fixed scoring limitation;
- a clear boundary between learning feedback and product information.

## Discarded evaluation runs

The first evaluation runner sent each complete case file to the model. Those files contained a private `Evaluation target` section after the raw question and essay.

An independent release review identified this leakage. All semantic results from those runs were discarded.

Evaluation targets were moved into separate files under `evals/expected/`. The runner also stops if it encounters a legacy `## Evaluation target` heading. `scripts/test-eval-input.sh` verifies that rendered model input contains only:

- the final Prompt;
- the Task 2 question;
- the Student essay.

## Final clean run

The final English and Chinese Prompts were each tested on all ten cases after:

- removing evaluation-target leakage;
- requiring exact capitalization and punctuation in evidence excerpts;
- making the planned full system explicitly unavailable;
- adding unexpected-heading detection for possible rewritten essays.

Total outputs: 20.

### Automated results

- required headings and order: 20/20 pass;
- no unexpected headings: 20/20 pass;
- exactly three priority problems: 20/20 pass;
- exactly three next-draft checkboxes: 20/20 pass;
- fixed scoring limitation: 20/20 pass;
- transparent planned-system note: 20/20 pass;
- at least seven evidence lines: 20/20 pass;
- quoted evidence matches exact contiguous essay text, including capitalization and punctuation: 20/20 pass.

### Manual semantic review

- designated primary weakness appeared among the three priorities: 18/20 pass;
- English Prompt primary-weakness match: 9/10;
- Chinese Prompt primary-weakness match: 9/10;
- designated unsupported diagnosis was avoided: 20/20 pass;
- no complete rewritten essay or replacement essay structure appeared: 20/20 pass;
- Case 09 was treated as clear and controlled rather than confused: pass;
- Case 10 received appropriate near-target feedback, but both languages identified general development limits instead of the fixture’s narrower crowd-control example: 2 misses.

The 9/10 per-entry-point semantic result meets the release rubric. The Case 10 misses remain documented rather than being hidden or rewritten after seeing the result.

## Reproduce

Running the evaluation requires a working Codex CLI session and model access:

```bash
./scripts/run-prompt-evals.sh
./scripts/test-eval-input.sh
./scripts/test-eval-checker.sh
node scripts/check-prompt-evals.mjs
```

Generated model inputs, outputs, and verbose runner logs are stored in `.eval-output/` and are intentionally excluded from Git because they are environment-dependent and can be regenerated.

The durable summary is committed as [`results.json`](results.json).

## Remaining user-acceptance check

Before public release, run the Prompt once in the actual ChatGPT interface. The automated runner is a Codex environment and cannot reproduce every model or product surface exactly.
