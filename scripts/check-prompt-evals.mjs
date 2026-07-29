import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const outputRoot = path.join(repoRoot, ".eval-output");
const caseRoot = path.join(repoRoot, "evals", "cases");

const requiredHeadings = [
  "## Submission Check",
  "## Training Reference Score Summary",
  "## Task Response",
  "## Coherence and Cohesion",
  "## Lexical Resource",
  "## Grammatical Range and Accuracy",
  "## Three Priority Problems",
  "## Next-Draft Checklist",
  "## Scoring Limitation",
  "## Optional Full-System Next Step",
];

const limitation =
  "This review is AI-generated practice feedback. Its training reference scores may vary and cannot replace an official IELTS result or qualified human assessment.";
const productNote =
  "This review identifies the three main problems in one essay. A complete review workflow can turn them into reusable error cards, targeted revision practice, and cross-essay progress tracking.";

function normalize(value) {
  return value.replace(/\s+/g, " ").trim();
}

function normalizeWords(value) {
  return value
    .normalize("NFKC")
    .replace(/[^\p{L}\p{N}']+/gu, " ")
    .replace(/\s+/g, " ")
    .trim()
    .toLowerCase();
}

function quotedEvidence(line) {
  const values = [];
  const patterns = [/“([^”]+)”/g, /"([^"]+)"/g];
  for (const pattern of patterns) {
    for (const match of line.matchAll(pattern)) {
      values.push(match[1]);
    }
  }
  return values;
}

const outputFiles = fs
  .readdirSync(outputRoot)
  .filter((name) => name.endsWith(".output.md"))
  .sort();

const failures = [];

if (outputFiles.length !== 20) {
  failures.push(`Expected 20 outputs, found ${outputFiles.length}`);
}

for (const outputName of outputFiles) {
  const output = fs.readFileSync(path.join(outputRoot, outputName), "utf8");
  const caseName = outputName.replace(/-(en|zh)\.output\.md$/, "");
  const casePath = path.join(caseRoot, `${caseName}.md`);
  const caseText = fs.readFileSync(casePath, "utf8");
  const essayText = normalize(
    caseText.split("## Student essay")[1].split("## Evaluation target")[0],
  );

  let previousIndex = -1;
  for (const heading of requiredHeadings) {
    const index = output.indexOf(heading);
    if (index === -1) {
      failures.push(`${outputName}: missing heading ${heading}`);
    } else if (index <= previousIndex) {
      failures.push(`${outputName}: heading out of order ${heading}`);
    }
    previousIndex = index;
  }

  const problemCount = (output.match(/Problem:/g) ?? []).length;
  if (problemCount !== 3) {
    failures.push(`${outputName}: expected 3 Problem labels, found ${problemCount}`);
  }

  const checkboxCount = (output.match(/^- \[ \]/gm) ?? []).length;
  if (checkboxCount !== 3) {
    failures.push(`${outputName}: expected 3 checkboxes, found ${checkboxCount}`);
  }

  if (!output.includes(limitation)) {
    failures.push(`${outputName}: fixed scoring limitation missing`);
  }
  if (!output.includes(productNote)) {
    failures.push(`${outputName}: fixed full-system note missing`);
  }
  if (/rewritten essay|model essay|high-band revised version/i.test(output)) {
    failures.push(`${outputName}: possible full-essay rewrite section`);
  }

  const evidenceLines = output
    .split(/\r?\n/)
    .filter((line) => /(?:Essay evidence|Evidence):/.test(line));
  if (evidenceLines.length < 7) {
    failures.push(
      `${outputName}: expected at least 7 evidence lines, found ${evidenceLines.length}`,
    );
  }

  for (const line of evidenceLines) {
    const excerpts = quotedEvidence(line);
    if (excerpts.length === 0) {
      failures.push(`${outputName}: evidence line has no quoted excerpt: ${line}`);
      continue;
    }
    for (const excerpt of excerpts) {
      if (/\.{3}|…/.test(excerpt)) {
        failures.push(`${outputName}: quoted evidence contains an ellipsis: ${excerpt}`);
        continue;
      }
      if (!normalizeWords(essayText).includes(normalizeWords(excerpt))) {
        failures.push(
          `${outputName}: quoted evidence is not exact essay text: ${excerpt}`,
        );
      }
    }
  }
}

if (failures.length > 0) {
  console.error(`Prompt evaluation checks failed (${failures.length}):`);
  for (const failure of failures) {
    console.error(`- ${failure}`);
  }
  process.exit(1);
}

console.log(`Prompt evaluation checks passed for ${outputFiles.length} outputs.`);
