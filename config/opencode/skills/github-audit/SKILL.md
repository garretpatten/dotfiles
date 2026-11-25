---
name: github-audit
description: "Audit all garretpatten repositories against the canonical standards in garretpatten/github-standards and report numbered findings with optional confirmed fixes via signed direct commits. Use for compliance reviews covering Dependabot, CI, rulesets, CODEOWNERS, LICENSE, SECURITY.md, CONTRIBUTING.md, permissions, pinning, and metadata."
metadata:
  type: workflow
  lifecycle: active
---

# github-audit — Standards Compliance Audit

Audit every owned repository under `garretpatten` (exclude `m11s`) against the canonical standards defined in https://github.com/garretpatten/github-standards. Produce a numbered findings report. Offer the user the option to fix one, a few, or all confirmed findings via signed direct commits to the default branch (admin bypass).

## Source of Truth

Load and follow the markdown files in `garretpatten/github-standards` (README.md, license.md, security-policy.md, contributing.md, community-files.md, codeowners.md, branch-protection.md, pull-requests.md, signed-commits.md, dependabot.md, dependency-hygiene.md, secret-hygiene.md, workflows-permissions.md, action-pinning.md, repository-metadata.md, readme-branding.md, ci-and-quality.md, exceptions.md, verification.md). The standards repository itself must also be audited and must be fully compliant.

## Embedded Standards Summary (for offline reference)

- **LICENSE**: MIT LICENSE file present at root (`LICENSE` or `LICENSE.md`) matching canonical text.
- **SECURITY.md**: Present (root or `.github/`) with private reporting instructions; no public issues for vulnerabilities. Dependabot alerts, dependency graph, secret scanning, and push protection enabled where available. Private vulnerability reporting enabled.
- **CONTRIBUTING.md**: Present with PR process, signed commits, CODEOWNERS reference, and pointer to SECURITY.md.
- **Community files**: README.md, LICENSE, SECURITY.md, CONTRIBUTING.md, CODEOWNERS required. Issue/PR templates recommended. Description and topics set. Admins accept content reports enabled. Code of Conduct optional for solo repos.
- **CODEOWNERS**: `.github/CODEOWNERS` (or root) with at least `* @garretpatten`. Code-owner review required by ruleset.
- **Branch protection**: Default branch `master`. Exactly one active ruleset named `CI` on `~DEFAULT_BRANCH` with deletion blocked, non_fast_forward blocked, required_signatures, pull_request rules (1 approval, dismiss stale, code-owner review, resolved threads, merge commits only), required_status_checks (strict). Admin (`RepositoryRole` 5) bypass always. No other rulesets. Private free-plan exceptions documented.
- **Signed commits**: Required by ruleset. Agents must produce signed commits.
- **Dependabot**: Alerts enabled. Security updates and version-update PRs disabled. Uniform `.github/dependabot.yaml` with `open-pull-requests-limit: 0` on `github-actions`. Manual updates only.
- **Dependency hygiene**: Lockfiles committed. No unnecessary floating ranges. Supply-chain scanning (security-guardrails) present.
- **Secret hygiene**: Secret scanning and push protection enabled. TruffleHog required. No secrets in code or history.
- **Workflow permissions**: Explicit `permissions:` block on every workflow. Least privilege (`contents: read` default). Write permissions justified by comment.
- **Action pinning**: All third-party actions pinned to full commit SHA with version comment. Own (`garretpatten`) actions may use tags only if documented; prefer SHAs.
- **Repository metadata**: Non-empty description, curated relevant topic set (3+ preferred; 1 is a finding, 0 is a violation), explicit visibility, default branch `master`.
- **README branding**: Centered header block (for-the-badge project badge, centered H1, bold tagline, one-sentence description), flat-square metadata badges (license, runtime), one workflow status badge per enabled CI workflow on the default branch; body is plain Markdown, succinct. Documentation-only repos may keep a plain README (documented). See readme-branding.md.
- **Pull requests**: Imperative titles (≤ ~60 chars, no WIP/issue-number noise); bodies link the related issue (`Closes #N`), bullet the changes, state verification; no automated footers/signatures. See pull-requests.md.
- **CI & quality**: Three components present (codeowners-enforcer, security-guardrails, quality-checks) from template, pinned. Linter toggles match content. Required checks match enabled jobs exactly. Yamllint + Markdownlint/Prettier always on.
- **Exceptions**: `m11s` fully excluded. `license-verifier` private free-plan limitations (no ruleset, no persistent Dependabot security-updates). Others listed in exceptions.md.

## Audit Workflow

1. List all owned repos:
   ```bash
   gh api user/repos --paginate --jq '.[] | select(.owner.login=="garretpatten") | .name'
   ```
   Exclude `m11s`. Record visibility.

2. For each repository (including `github-standards`), verify against the standards files using `gh api` / file content checks as described in verification.md:
   - LICENSE presence and MIT content.
   - SECURITY.md and CONTRIBUTING.md presence and required sections.
   - CODEOWNERS content.
   - Community files and metadata (description, topics).
   - Ruleset existence, name, rules, bypass, and exact required status checks.
   - Signed-commit enforcement.
   - Dependabot settings and uniform dependabot.yaml.
   - Workflow permissions blocks (least privilege).
   - Action pins (SHA for third-party; documented exceptions for own).
   - Presence of the three CI workflows and linter/content match.
   - Secret scanning / push protection status where queryable.
   - Lockfile presence for detected languages.

3. Collect divergences as numbered findings. Group by repository. Include observed value, expected standard (citing the standards file), and severity (Critical / High / Medium).

4. Output the report:
   - Summary: repos scanned, total findings, critical count, auto-fixable count.
   - Numbered list (e.g., `1. repo-name: missing MIT LICENSE (expected per license.md)`).
   - Note known exceptions from exceptions.md so they are not re-reported.

5. Ask the user which findings to fix: specific numbers, a range, “all”, or “none”. Wait for confirmation.

6. For confirmed findings only:
   - Apply via signed direct commit to the default branch (admin bypass permitted).
   - Use minimal diffs that restore canonical files or settings.
   - Do not open PRs unless the user explicitly requests them.
   - After each commit (or batch), re-verify the fixed checks and report pass/fail.

## GitHub CLI Pitfalls

- Do not use `gh pr edit` or `gh issue edit` to update a title or body — its GraphQL
  query includes deprecated Projects-classic fields and fails with a schema/deprecation
  error. Use the REST API instead: `gh api repos/{owner}/{repo}/pulls/<number> -X PATCH`
  with `-F title=...` or `--input <file>` containing `{"body": "..."}`.
- If any `gh` GraphQL call fails with a Projects (classic) deprecation error, switch to
  the equivalent REST endpoint; never retry the GraphQL call.

## Output Format

Findings (N total, C critical):

1. [repo] [standard]: [observed] (expected: [standard from github-standards/...])
2. ...

Select findings to fix (numbers, 'all', or 'none'):

Do not soften standards. Report private-plan limitations factually. Prefer loading live content from `garretpatten/github-standards` when network access is available.
