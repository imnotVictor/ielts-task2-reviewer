# Reviewer Evaluation Rubric

Run every evaluation case through both the English Prompt and the Chinese Prompt. Run cases 01, 08, and 10 through the Codex Skill as well.

Record model, date, entry point, output file, and pass/fail for every check.

## Eight required checks

1. **Four criteria:** All four criterion sections appear in the required order.
2. **Exact evidence:** Every major judgment quotes text that exists in the submitted essay.
3. **Three priorities:** The output contains exactly three priority problems.
4. **Actionability:** Every priority includes a specific next-draft action.
5. **No invention:** The output does not claim an error that is absent from its quoted evidence.
6. **No full rewrite:** The output does not replace the essay with a complete rewritten version.
7. **Scoring limitation:** The fixed limitation is present and scores are called training reference scores.
8. **Separated product note:** The optional full-system note appears only after the learning feedback and stays within two sentences.

## Passing threshold

An entry point passes when:

- all eight checks pass on at least 9 of the 10 cases;
- evidence citation passes on all 10 cases;
- the scoring limitation passes on all 10 cases;
- the reviewer refuses to score when the Task 2 question or essay is missing;
- repeated runs may vary in score, but identify substantially the same primary weakness.

## Case-specific checks

Each raw file in `cases/` contains only the question and essay sent to the model. Its same-named file in `expected/` supplies:

- one primary weakness the reviewer should identify;
- three exact evidence anchors available to support feedback;
- one unsupported diagnosis the reviewer must not invent.

The reviewer does not have to quote all three anchors. It must use evidence that actually exists and identify the primary weakness among its three priorities.
