# Evaluation Run Log

Product version: `1.0.0`

## Baseline failure

Instruction tested:

> Review this IELTS Task 2 essay.

Cases tested: 01, 08, and 10.

Observed failures:

- no guaranteed four-criterion structure;
- no requirement to quote exact evidence;
- no exact three-problem limit;
- no fixed scoring limitation;
- no separation between learning feedback and product information.

Conclusion: the one-line instruction is not sufficient for a stable public reviewer.

## Full Prompt evaluations

Date: 2026-07-29  
Runner: Codex CLI `0.137.0`, ephemeral read-only sessions  
Model reported by runner: `gpt-5.5`  
Entry points: English Prompt and Chinese Prompt  
Cases per entry point: 10  
Total outputs: 20

### First full run

The structural checker identified two evidence-copying failures:

- the English output for Case 03 inserted an ellipsis into a quotation;
- the Chinese output for Case 06 joined an excerpt with an ellipsis.

The Prompt evidence rule was tightened to require exact contiguous text and prohibit inserted ellipses.

### Final full run

All 20 outputs were regenerated from the final Prompt versions.

Automated results:

- required headings and order: 20/20 pass;
- exactly three priority problems: 20/20 pass;
- exactly three next-draft checkboxes: 20/20 pass;
- fixed scoring limitation: 20/20 pass;
- separated two-sentence product note: 20/20 pass;
- no full-essay rewrite section: 20/20 pass;
- at least seven evidence lines: 20/20 pass;
- quoted evidence matches contiguous words in the submitted essay: 20/20 pass.

Manual semantic review:

- the case’s designated primary weakness appeared among the three priorities: 20/20 pass;
- no case used its designated unsupported diagnosis as a priority: 20/20 pass;
- Case 09 was treated as clear and controlled rather than penalised as confused: pass;
- Case 10 was recognised as near the target level while still identifying limited development: pass.

### Remaining release check

Before public release, run a short user-acceptance test in the actual ChatGPT interface because the automated runner is a Codex environment and may not reproduce every model or product surface exactly.
