# v1.0.0 发布收尾实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task by task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将已经验证的 IELTS Task 2 Reviewer 整理为以 `main` 为默认分支、带有 `v1.0.0` Tag 和双语 GitHub Release 的正式公开版本。

**Architecture:** 所有公开发布对象都指向同一个通过完整验证的不可变提交。先在本地完成 Release 文案和验证，再依次推送 `main`、设置默认分支、推送 Tag、创建 Release，最后通过 GitHub API 和全新克隆独立复核。

**Tech Stack:** Git、GitHub CLI、Shell、现有 Node.js 验证脚本、Codex Skill 验证器。

## 全局约束

- 不改变 Prompt 行为、评测预期、许可条款或完整版规划范围。
- `feature/free-reviewer-v1` 必须保留，不强制推送、不删除。
- `main`、`v1.0.0` Tag 和 GitHub Release 必须指向同一个通过最终验证的提交。
- 如果远端 `main`、`v1.0.0` Tag 或同名 Release 已存在且状态不符合预期，立即停止检查，不覆盖。
- 任何远端变更之前，工作区必须干净且 `./scripts/validate-release.sh --phase full` 必须通过。
- Release 必须明确说明 AI 分数是训练参考分而非官方 IELTS 成绩，并保留个人非商业使用边界。

---

### Task 1: 准备可复用的双语 Release 文案

**Files:**
- Create: `.github/releases/v1.0.0.md`
- Test: `scripts/validate-release.sh`

**Interfaces:**
- Consumes: `README.md`、`README.zh-CN.md`、`CHANGELOG.md`、`LICENSE.md` 中已经公开的产品范围和措辞。
- Produces: 可直接传给 `gh release create --notes-file` 的 UTF-8 Markdown 文件。

- [ ] **Step 1: 创建 Release 文案**

创建 `.github/releases/v1.0.0.md`，内容必须完整如下：

```markdown
# IELTS Task 2 Reviewer v1.0.0

A free, reusable AI reviewer for a single IELTS Writing Task 2 essay, available as bilingual prompts and an installable Codex Skill.

一个可以永久重复使用的 IELTS Writing Task 2 单篇作文 AI 批改器，提供中英文 Prompt 和可安装的 Codex Skill。

## Included / 本版本包含

- Reusable English and Chinese reviewer prompts / 可重复使用的中英文批改 Prompt
- Installable Codex Skill / 可安装的 Codex Skill
- Four training-reference scores with exact essay evidence / 四项训练参考分与作文原文证据
- Exactly three priority problems and three next-draft checks / 三个优先问题与三个下一稿检查项
- Bilingual quick-start and scoring-boundary documentation / 中英文快速入门与评分边界说明
- Original examples, public evaluation cases, results, and validation scripts / 原创示例、公开评测案例、结果和验证脚本

## Start here / 开始使用

- [English quick start](https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/docs/quick-start.md)
- [中文快速入门](https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/docs/quick-start.zh-CN.md)
- [English prompt](https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/prompts/task2-reviewer-en.md)
- [中文 Prompt](https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/prompts/task2-reviewer-zh.md)

## Important limitations / 重要边界

Generated scores are training references, not official IELTS scores. This project is not affiliated with or endorsed by IELTS, the British Council, IDP, or Cambridge University Press & Assessment.

生成的分数属于训练参考分，并非官方 IELTS 成绩。本项目与 IELTS、British Council、IDP 和 Cambridge University Press & Assessment 不存在隶属或官方背书关系。

This release is licensed for personal, non-commercial use only. Read [LICENSE.md](https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/LICENSE.md) before use, modification, or redistribution.

本版本仅授权个人非商业使用。使用、修改或再分发前请阅读 [LICENSE.md](https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/LICENSE.md)。
```

- [ ] **Step 2: 检查文案边界与链接**

运行：

```bash
rg -n "training references|训练参考分|personal, non-commercial|个人非商业" .github/releases/v1.0.0.md
rg -n "https://github\\.com/imnotVictor/ielts-task2-reviewer/blob/v1\\.0\\.0/" .github/releases/v1.0.0.md
```

预期：第一条命令同时命中中英文评分及许可边界；第二条命令命中五个固定到 `v1.0.0` 的仓库链接。

- [ ] **Step 3: 提交 Release 文案**

```bash
git add .github/releases/v1.0.0.md
git diff --cached --check
git commit -m "docs: add v1.0.0 release notes"
```

预期：提交成功，提交只包含 `.github/releases/v1.0.0.md`。

### Task 2: 执行发布前验证与冲突检查

**Files:**
- Verify: `VERSION`
- Verify: `scripts/validate-release.sh`
- Verify: repository and GitHub state

**Interfaces:**
- Consumes: Task 1 提交后的干净工作树。
- Produces: 一个已记录 commit SHA；后续 `main`、Tag 和 Release 都必须指向它。

- [ ] **Step 1: 验证本地版本与工作区**

运行：

```bash
test "$(cat VERSION)" = "1.0.0"
test -z "$(git status --porcelain)"
git status --short --branch
```

预期：前两条命令退出码为 0；状态显示当前 feature 分支相对远端领先，但没有未提交文件。

- [ ] **Step 2: 运行完整发布验证**

运行：

```bash
./scripts/validate-release.sh --phase full
```

预期：完整验证退出码为 0，Prompt、评测、链接与 Skill 验证全部通过。

- [ ] **Step 3: 核对 GitHub 身份与远端冲突**

运行：

```bash
/opt/homebrew/bin/gh auth status
test "$(/opt/homebrew/bin/gh api user --jq '.login')" = "imnotVictor"
test -z "$(git ls-remote --heads origin main)"
test -z "$(git ls-remote --tags origin refs/tags/v1.0.0)"
if /opt/homebrew/bin/gh release view v1.0.0 \
  -R imnotVictor/ielts-task2-reviewer >/dev/null 2>&1
then
  echo "v1.0.0 Release already exists; stop for inspection." >&2
  exit 1
fi
```

预期：所有命令退出码为 0，认证用户是 `imnotVictor`，远端 `main`、`v1.0.0` Tag 和同名 Release 均不存在。

- [ ] **Step 4: 记录唯一发布提交**

运行：

```bash
git rev-parse HEAD
```

预期：得到一个 40 位 commit SHA。后续所有远端对象必须与该 SHA 完全一致。

### Task 3: 建立正式默认分支并发布 v1.0.0

**Files:**
- Remote branch: `main`
- Remote tag: `v1.0.0`
- GitHub Release: `v1.0.0`

**Interfaces:**
- Consumes: Task 2 记录的已验证 commit SHA 和 `.github/releases/v1.0.0.md`。
- Produces: 指向同一提交的默认分支、Tag 和公开 Release。

- [ ] **Step 1: 从已验证提交建立本地 main**

运行：

```bash
git switch -c main
test "$(git rev-parse HEAD)" = "$(git rev-parse feature/free-reviewer-v1)"
```

预期：切换到新的本地 `main`；HEAD 与刚刚通过验证的 feature 分支提交相同。

- [ ] **Step 2: 推送 main**

运行：

```bash
git push -u origin main
```

预期：远端建立 `main`，本地 `main` 跟踪 `origin/main`，没有强制推送。

- [ ] **Step 3: 将 main 设为默认分支**

运行：

```bash
/opt/homebrew/bin/gh repo edit imnotVictor/ielts-task2-reviewer --default-branch main
/opt/homebrew/bin/gh repo view imnotVictor/ielts-task2-reviewer --json defaultBranchRef --jq '.defaultBranchRef.name'
```

预期：输出 `main`。

- [ ] **Step 4: 创建并推送带说明的 Tag**

运行：

```bash
git tag -a v1.0.0 -m "IELTS Task 2 Reviewer v1.0.0"
git push origin v1.0.0
```

预期：本地和远端都出现 `v1.0.0`，Tag 解引用后的 commit 与已验证 SHA 相同。

- [ ] **Step 5: 创建 GitHub Release**

运行：

```bash
/opt/homebrew/bin/gh release create v1.0.0 \
  -R imnotVictor/ielts-task2-reviewer \
  --title "IELTS Task 2 Reviewer v1.0.0" \
  --notes-file .github/releases/v1.0.0.md \
  --verify-tag \
  --latest
```

预期：命令返回公开 Release URL，Release 不是草稿或预发布版本。

### Task 4: 独立验证公开发布结果

**Files:**
- Verify: GitHub repository metadata
- Verify: Git refs
- Verify: clean clone

**Interfaces:**
- Consumes: Task 3 创建的 GitHub 对象。
- Produces: 可复核的默认分支、commit、Tag、Release 和全新克隆验证证据。

- [ ] **Step 1: 通过 GitHub API 核对公开对象**

运行：

```bash
/opt/homebrew/bin/gh repo view imnotVictor/ielts-task2-reviewer \
  --json defaultBranchRef,url \
  --jq '{defaultBranch: .defaultBranchRef.name, url: .url}'
/opt/homebrew/bin/gh api repos/imnotVictor/ielts-task2-reviewer/git/ref/tags/v1.0.0
/opt/homebrew/bin/gh release view v1.0.0 \
  -R imnotVictor/ielts-task2-reviewer \
  --json tagName,name,isDraft,isPrerelease,url,targetCommitish
```

预期：默认分支为 `main`；Tag 为 `v1.0.0`；Release 名称正确，`isDraft` 和 `isPrerelease` 均为 `false`。

- [ ] **Step 2: 核对三个远端对象指向同一提交**

运行：

```bash
git fetch origin main refs/tags/v1.0.0
test "$(git rev-parse origin/main)" = "$(git rev-parse feature/free-reviewer-v1)"
test "$(git rev-list -n 1 v1.0.0)" = "$(git rev-parse feature/free-reviewer-v1)"
```

预期：两项比较均退出码为 0，证明 `origin/main` 和 Tag 都指向经过验证的 feature 分支提交。

- [ ] **Step 3: 在全新克隆中运行发布验证**

运行：

```bash
RELEASE_VERIFY_DIR="$(mktemp -d)"
git clone --branch v1.0.0 --depth 1 \
  https://github.com/imnotVictor/ielts-task2-reviewer.git \
  "$RELEASE_VERIFY_DIR/ielts-task2-reviewer"
cd "$RELEASE_VERIFY_DIR/ielts-task2-reviewer"
./scripts/validate-release.sh --phase full
```

预期：从公开 `v1.0.0` 克隆成功，完整发布验证退出码为 0。

- [ ] **Step 4: 核对 Release 中的固定链接**

运行：

```bash
for release_path in \
  docs/quick-start.md \
  docs/quick-start.zh-CN.md \
  prompts/task2-reviewer-en.md \
  prompts/task2-reviewer-zh.md \
  LICENSE.md
do
  curl -fsSL -o /dev/null \
    "https://github.com/imnotVictor/ielts-task2-reviewer/blob/v1.0.0/$release_path"
done
```

预期：五个固定版本链接全部返回成功。

- [ ] **Step 5: 最终状态检查**

回到原仓库后运行：

```bash
git status --short --branch
git log -1 --oneline --decorate
```

预期：位于 `main`，跟踪 `origin/main`，工作区干净；HEAD 同时带有 `v1.0.0` 标记。
