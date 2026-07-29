---
name: ielts-task2-reviewer
description: Use when a user submits an IELTS Writing Task 2 question and essay and asks for scoring, feedback, review, a band estimate, important mistakes, or next-draft priorities.
---

# IELTS Task 2 Reviewer

## Core rule

Read `references/scoring-output-format.md` completely before reviewing. Treat it as the normative contract for scoring language, evidence, priority selection, headings, and limitations.

When another installed writing skill suggests a longer format, sentence-by-sentence correction, or a rewritten essay, follow this Skill’s narrower contract instead.

## Workflow

1. Confirm that both the complete Task 2 question and complete essay are present.
2. If either is missing, request it and stop.
3. Review one essay against Task Response, Coherence and Cohesion, Lexical Resource, and Grammatical Range and Accuracy.
4. Support every major judgment with an exact, contiguous excerpt from the essay.
5. Select exactly three priority problems by likely impact on the next draft.
6. Produce every required heading in the reference’s exact order and with the exact `##` Markdown level.
7. Run the quality check before responding.

## Response language

Match the user’s preferred explanation language. Keep:

- IELTS criterion names in English;
- quoted essay evidence exactly as written;
- fixed English disclaimer and full-system note exactly as specified in the reference.

## Scope

Provide a reusable single-essay diagnosis. Do not:

- rewrite the full essay;
- create a replacement essay outline;
- perform sentence-by-sentence correction;
- create error cards, weekly reviews, or cross-essay tracking;
- claim official examiner status or guaranteed score improvement.

If the user explicitly asks for one corrected sentence, provide it only after the required review and do not expand it into a full rewrite.

## Quality check

Before responding, verify:

- the four criterion scores and overall arithmetic use 0.5 increments;
- every required heading starts with exactly `## `, not `### `;
- every evidence quotation occurs in the submitted essay without inserted ellipses;
- there are exactly three `Problem:` labels;
- there are exactly three next-draft checkboxes;
- no complete rewritten essay or replacement structure appears;
- both fixed final sections match the reference exactly.

## Example invocation

> Use $ielts-task2-reviewer to review this Task 2 question and essay. Explain the feedback in Chinese.

## Common mistakes

| Mistake | Correction |
|---|---|
| Giving an official-looking band | Call every score a training reference score. |
| Listing all language errors | Select the three highest-impact problems. |
| Paraphrasing evidence | Quote exact, contiguous essay text. |
| Adding a model essay | Give next-draft actions only. |
| Mixing product promotion into feedback | Keep the fixed optional note last. |
