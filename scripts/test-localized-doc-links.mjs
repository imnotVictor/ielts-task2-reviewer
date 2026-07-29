#!/usr/bin/env node

import { access, readFile } from "node:fs/promises";

const chineseReadme = "README.zh-CN.md";
const expectedChineseDocs = [
  "docs/quick-start.zh-CN.md",
  "docs/scoring-disclaimer.zh-CN.md",
  "docs/full-version.zh-CN.md",
];

const readme = await readFile(chineseReadme, "utf8");
const docLinks = [...readme.matchAll(/\]\((docs\/[^)#]+\.md)(?:#[^)]+)?\)/g)].map(
  ([, target]) => target,
);

const errors = [];

for (const expected of expectedChineseDocs) {
  if (!docLinks.includes(expected)) {
    errors.push(`${chineseReadme} must link to ${expected}`);
  }
}

for (const target of docLinks) {
  if (!target.endsWith(".zh-CN.md")) {
    errors.push(`Chinese README links to a non-Chinese document: ${target}`);
  }

  try {
    await access(target);
  } catch {
    errors.push(`Linked document does not exist: ${target}`);
  }
}

for (const target of expectedChineseDocs) {
  try {
    const document = await readFile(target, "utf8");
    if (!document.includes("(../README.zh-CN.md)")) {
      errors.push(`${target} must link back to ../README.zh-CN.md`);
    }
  } catch {
    errors.push(`Expected Chinese document does not exist: ${target}`);
  }
}

if (errors.length > 0) {
  console.error(errors.join("\n"));
  process.exit(1);
}

console.log("Chinese README and documentation links are valid.");
