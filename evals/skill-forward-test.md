# Codex Skill Forward Test

Date: 2026-07-29

## Method

Fresh agents received:

- the path to `codex-skill/ielts-task2-reviewer`;
- one raw Task 2 question and essay;
- an instruction not to read the case’s evaluation target.

They did not receive the expected diagnosis or prior conclusions.

Cases:

- Case 01: partial and off-topic response;
- Case 08: frequent grammar errors;
- Case 10: near-target response.

## First pass

All three runs:

- used all four criteria;
- labeled scores as training reference scores;
- quoted exact essay evidence;
- selected exactly three priority problems;
- provided exactly three next-draft checkboxes;
- avoided a full rewrite and replacement structure;
- included both fixed final sections;
- identified the intended primary weakness.

One formatting gap appeared: agents used `###` headings although the shared contract specified `##`.

## Refinement

The Skill was updated to require the exact `##` Markdown heading level in both its workflow and quality check.

## Retest

Case 01 was rerun in a fresh context.

Result:

- every required heading used `##`;
- all headings appeared in the required order;
- exact evidence was used for all four criteria and three priorities;
- exactly three priorities and three checkboxes appeared;
- no full rewrite or replacement structure appeared;
- both fixed final sections matched the contract.

Status: pass.
