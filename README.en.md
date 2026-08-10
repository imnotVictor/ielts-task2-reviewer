# IELTS Task 2 Reviewer

[中文说明](README.md)

A reusable Prompt and Codex Skill that reviews one IELTS Writing Task 2 essay, cites exact evidence, and identifies exactly three priorities for the next draft.

Version: `1.0.0`

![Controlled comparison: generic review passed 2 of 11 quality gates; the IELTS Reviewer Skill passed 11 of 11](docs/assets/skill-ab-comparison.svg)

*Controlled single-essay comparison: same question, essay, GPT-5.5 model, and an independent blind judge. This `n = 1` result demonstrates the review contract rather than claiming universal scoring accuracy.*

## Why this exists

Generic AI feedback often produces a score, a long error list, and a rewritten essay. That can be difficult to turn into focused practice.

This reviewer uses a smaller contract:

1. review all four IELTS Writing criteria;
2. support judgments with exact words from the essay;
3. select the three highest-impact problems;
4. turn those problems into three next-draft checks;
5. avoid rewriting the full essay.

## What you receive

- an English universal Prompt;
- a Chinese-interface universal Prompt;
- an installable Codex Skill;
- an original sample essay and complete review;
- ten original evaluation cases;
- public evaluation notes and validation scripts.

Unlimited use is included. There is no essay counter, expiry date, online activation, or intentionally weakened trial.

## 60-second start

### ChatGPT or another capable AI assistant

Open one of these files:

- [English Prompt](prompts/task2-reviewer-en.md)
- [Chinese-interface Prompt](prompts/task2-reviewer-zh.md)

Copy the entire `Prompt` code block into a new conversation, then paste the complete Task 2 question and essay.

### Codex

Clone this repository, then copy the Skill into your user Skill directory:

```bash
mkdir -p "$HOME/.agents/skills"
cp -R codex-skill/ielts-task2-reviewer "$HOME/.agents/skills/ielts-task2-reviewer"
```

Invoke it with:

```text
Use $ielts-task2-reviewer to review this Task 2 question and essay. Explain the feedback in Chinese.
```

See the [complete quick start](docs/quick-start.md) for repository-scoped installation and troubleshooting.

## Example

Input excerpt:

> Educated people are useful, and every country needs useful people.

Reviewer output:

> **Problem:** Ideas are relevant but underdeveloped.
>
> **Why this is a priority:** The essay gives a valid reason but does not explain the mechanism clearly.
>
> **Next-draft action:** Explain exactly how free university creates social or economic benefits.

Read the [original sample essay](examples/sample-essay.md) and [complete sample review](examples/sample-review.md).

## Output

Every complete review includes:

- Submission Check;
- Training Reference Score Summary;
- Task Response;
- Coherence and Cohesion;
- Lexical Resource;
- Grammatical Range and Accuracy;
- Three Priority Problems;
- Next-Draft Checklist;
- Scoring Limitation.

All scores are AI-generated training reference scores, not official IELTS scores.

## Quality and evaluation

The final English and Chinese Prompts were tested against ten original cases covering:

- off-topic response;
- underdeveloped ideas;
- weak examples;
- paragraph progression;
- mechanical cohesion;
- repetitive vocabulary;
- collocation errors;
- frequent grammar errors;
- simple but clear language;
- a near-target essay.

The final 20 Prompt outputs were generated without access to the expected diagnoses. They passed automated checks for structure, exact evidence, priority count, disclaimer, and unexpected rewrite headings. Manual review matched the designated primary weakness in 9 of 10 cases for each language and found no full rewritten essay. The Skill also passed fresh-context forward tests on three representative cases.

Review the [evaluation rubric](evals/evaluation-rubric.md), [machine-readable results](evals/results.json), [Prompt run log](evals/run-log.md), and [Skill forward test](evals/skill-forward-test.md).

## Scoring basis and limitations

The review structure is informed by current public IELTS explanations of the four Writing criteria. The project paraphrases those criteria and does not reproduce commercial teaching content or full descriptor tables.

Sources and limitations are recorded in [Scoring Basis and Limitations](docs/scoring-disclaimer.md).

This project is not affiliated with or endorsed by IELTS, the British Council, IDP, or Cambridge University Press & Assessment.

## Free reviewer versus full system

The free reviewer permanently handles single-essay diagnosis. A separate full system is planned for question analysis, error cards, targeted revision, repeated-error tracking, weekly review, and a Notion notebook.

The full system is still in development. See the [transparent feature comparison](docs/full-version.md).

## Usage terms

This project is available for individual non-commercial study only. You may not resell it, share copies, publicly re-upload it, repackage it, or use it to provide paid essay review, tutoring, or other commercial services.

Read [LICENSE.md](LICENSE.md) before using or adapting the files.
