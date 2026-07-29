# Quick Start

IELTS Task 2 Reviewer can be used in two ways:

- copy the universal Prompt into ChatGPT or another capable AI assistant;
- install the Skill for Codex.

## Use the universal Prompt

Choose one file:

- English interface: [`prompts/task2-reviewer-en.md`](../prompts/task2-reviewer-en.md)
- Chinese interface: [`prompts/task2-reviewer-zh.md`](../prompts/task2-reviewer-zh.md)

Copy everything inside its `Prompt` code block into a new conversation. Then submit:

1. the complete Task 2 question;
2. your complete essay.

The Prompt can be reused without an essay limit.

## Install the Codex Skill for your user account

From the cloned repository, run:

```bash
mkdir -p "$HOME/.agents/skills"
cp -R codex-skill/ielts-task2-reviewer "$HOME/.agents/skills/ielts-task2-reviewer"
```

If a folder with that name already exists, move the old folder to a backup location before copying the new version.

Codex detects Skill changes automatically. If the Skill does not appear, restart Codex.

## Install for one repository

From the target repository root:

```bash
mkdir -p .agents/skills
cp -R /path/to/ielts-task2-reviewer/codex-skill/ielts-task2-reviewer .agents/skills/ielts-task2-reviewer
```

Repository-scoped Skills are available when Codex runs inside that repository.

## Invoke the Skill

In Codex CLI or the IDE extension, type `$` to mention the Skill or use `/skills`.

Example:

```text
Use $ielts-task2-reviewer to review this Task 2 question and essay. Explain the feedback in Chinese.
```

The Skill can also activate implicitly when a request clearly asks for IELTS Writing Task 2 scoring or feedback.

## What to submit

Use this format:

```text
Task 2 question:
[paste the complete question]

Essay:
[paste your complete essay]
```

If the question or essay is missing, the reviewer will request it before scoring.

## Important limitation

All displayed scores are AI-generated training reference scores. They are not official IELTS results and do not guarantee score improvement.

## Official Codex Skill documentation

- [Build skills](https://learn.chatgpt.com/docs/build-skills.md)
- [OpenAI Agent Skills specification](https://agentskills.io)
