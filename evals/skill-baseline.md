# Codex Skill Baseline

Date: 2026-07-29

## Scenario

A fresh agent received only:

- a natural Chinese request to score a Task 2 essay and identify the most important improvement;
- the complete question from Case 01;
- the complete essay from Case 01.

The agent was explicitly told not to inspect workspace files. The new `ielts-task2-reviewer` Skill did not exist.

## Observed baseline behavior

The agent correctly recognised the off-topic response, but it did not follow the product’s required review contract:

- it used `预估分数` rather than consistently labeling every score as a training reference score;
- it did not cite exact essay evidence for every criterion;
- it did not select exactly three structured priority problems;
- it proposed a full multi-paragraph replacement structure;
- it supplied a rewritten introduction;
- it did not use the fixed scoring limitation;
- it did not separate the optional full-system note from learning feedback.

## Skill requirements proved by the failure

The Skill must:

1. load the shared scoring and output contract;
2. require exact evidence for each criterion;
3. select exactly three priority problems;
4. avoid a full rewrite or replacement essay structure;
5. use training-reference language and the fixed limitation;
6. keep the optional full-system note in its required final position.
