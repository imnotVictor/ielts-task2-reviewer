# v1.0.0 Release Closeout Design

## Goal

Turn the already validated IELTS Task 2 Reviewer repository into a conventional, clearly identifiable public `v1.0.0` release without changing the reviewer’s behavior or expanding the paid-product scope.

## Scope

The release closeout will:

1. run the repository’s full release validation against the current commit;
2. establish `main` at the validated commit and make it the GitHub default branch;
3. preserve `feature/free-reviewer-v1` so existing links remain valid;
4. create and push the `v1.0.0` tag;
5. publish a GitHub Release with concise English and Chinese guidance;
6. verify the public default branch, tag, Release page, README links, and clean-clone installation path.

The release closeout will not change prompt behavior, evaluation expectations, licensing terms, or the planned full-version feature set.

## Release Content

The GitHub Release will identify the following deliverables:

- reusable English and Chinese Task 2 reviewer prompts;
- installable Codex Skill;
- bilingual quick-start and scoring-boundary documentation;
- original sample essay and review;
- public evaluation cases, results, and validation scripts.

It will state that generated scores are training references rather than official IELTS scores and that the repository is licensed for personal, non-commercial use under `LICENSE.md`.

## Branch and Tag Strategy

`main` will point to the exact commit that passes the final validation. It will become the default branch before the Release is published. The existing remote feature branch will remain available and will not be force-pushed or deleted.

The `v1.0.0` tag and GitHub Release will target the verified `main` commit. If a `v1.0.0` tag or Release unexpectedly already exists, execution will stop for inspection rather than overwrite it.

## Verification and Failure Handling

Before remote changes, the working tree must be clean and the full release validator must pass. After publication, local Git, the GitHub API, and a clean clone will be checked independently.

If validation fails, no Tag or Release will be created. If a remote step partially succeeds, the completed state will be inspected before any retry; destructive cleanup or history rewriting is outside this closeout.
