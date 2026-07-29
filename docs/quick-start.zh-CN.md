# 快速入门

[返回中文 README](../README.zh-CN.md)

IELTS Task 2 写作批改器有两种使用方式：

- 将通用 Prompt 复制到 ChatGPT 或其他能力足够的 AI 助手；
- 为 Codex 安装 Skill。

## 使用通用 Prompt

选择一个文件：

- 英文界面：[`prompts/task2-reviewer-en.md`](../prompts/task2-reviewer-en.md)
- 中文界面：[`prompts/task2-reviewer-zh.md`](../prompts/task2-reviewer-zh.md)

复制文件中 `Prompt` 代码块的全部内容并粘贴到新对话，然后提交：

1. 完整的 Task 2 题目；
2. 完整的作文。

该 Prompt 可以不限次数重复使用。

## 为个人账户安装 Codex Skill

在克隆后的仓库中运行：

```bash
mkdir -p "$HOME/.agents/skills"
cp -R codex-skill/ielts-task2-reviewer "$HOME/.agents/skills/ielts-task2-reviewer"
```

如果已经存在同名文件夹，请先将旧文件夹移到其他位置备份，再复制新版本。

Codex 会自动检测 Skill 变更。如果 Skill 没有出现，请重新启动 Codex。

## 为单个项目安装

在目标项目的根目录运行：

```bash
mkdir -p .agents/skills
cp -R /path/to/ielts-task2-reviewer/codex-skill/ielts-task2-reviewer .agents/skills/ielts-task2-reviewer
```

当 Codex 在该项目中运行时，即可使用项目级 Skill。

## 调用 Skill

在 Codex CLI 或 IDE 扩展中输入 `$` 来提及该 Skill，也可以使用 `/skills`。

示例：

```text
Use $ielts-task2-reviewer to review this Task 2 question and essay. Explain the feedback in Chinese.
```

当请求明确要求对 IELTS Writing Task 2 评分或提供反馈时，该 Skill 也可能自动触发。

## 提交格式

请使用以下格式：

```text
Task 2 question:
[粘贴完整题目]

Essay:
[粘贴完整作文]
```

如果缺少题目或作文，批改器会先要求补充，再开始评分。

## 重要限制

所有显示的分数都是 AI 生成的训练参考分，不是官方 IELTS 成绩，也不保证提分。

## Codex Skill 官方文档

- [创建 Skills](https://learn.chatgpt.com/docs/build-skills.md)
- [OpenAI Agent Skills 规范](https://agentskills.io)
