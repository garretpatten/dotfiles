---
name: Resolve Issue
description: Resolve a GitHub Issue in the checked out repository — branch off, implement the fix, commit, push, and open a PR that closes the issue. Invoke with `@resolve-issue` plus the issue number.
---

# Resolve GitHub Issue

You are resolving GitHub Issue **$ARGUMENTS** in the currently checked out repository.

## Workflow

1. **Fetch the issue context**
   - Run `gh issue view <number>` to read the issue title, body, and comments.
   - If the issue references linked files, reproduce the problem to confirm you understand it before changing anything.

2. **Create (or switch to) the issue branch**
   - The branch must be named `issue-<number>` (e.g. issue-22).
   - If it does not exist: `git checkout master && git pull && git checkout -b issue-<number>`.
   - If it already exists locally or on origin, check it out and merge or rebase onto the latest master so you are working from current code.
   - Never commit directly to master.

3. **Resolve the issue**
   - Implement exactly the work the issue describes — keep the change scoped to it. Do not fix unrelated bugs or refactor opportunistically.
   - Follow the repository's existing conventions: style, structure, naming, and test practices.
   - If the issue is ambiguous, state your interpretation and proceed with the narrowest reasonable reading; surface the assumption in the PR description.
   - Run the repo's own tests/build/lint if available, and add or update tests when the change warrants it.

4. **Commit and push**
   - Stage and commit the scoped work with a concise imperative message (e.g. `Fix duplicate user creation on rapid signup (closes #22)`).
   - Push the branch: `git push -u origin issue-<number>`.

5. **Open a pull request to master**
   - Base is **master** (not main, unless this repo's default is main).
   - `gh pr create --base master --title "<Concise imperative title>" --body "<PR description>"`.
   - The PR body must be succinct and readable at a glance:
     - One sentence stating what changed and why.
     - A short bullet list of the key changes.
     - A "Closes #<number>" line on its own so merging the PR automatically closes the issue.
   - Output the PR URL to the user.
