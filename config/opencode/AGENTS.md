# Global agent rules

## GitHub CLI: no GraphQL for PR/issue body and title edits

`gh pr edit` (and other `gh` GraphQL calls whose query includes the deprecated
Projects-classic fields, e.g. `projectCards` / `projects`) fails with a GraphQL
deprecation/schema error. This happens frequently and is a known `gh` bug, not a
problem with the repository or permissions.

- **Never use `gh pr edit` or `gh issue edit`** to change a title or body.
- **Never retry the failing GraphQL call** after this error — it will fail the
  same way every time. Switch to the REST API immediately.
- Edit a pull request title/body via REST instead:

  ```sh
  gh api repos/{owner}/{repo}/pulls/<number> -X PATCH -F title='New title'
  gh api repos/{owner}/{repo}/pulls/<number> -X PATCH --input <file>
  ```

  For bodies, write the payload to a temp file (e.g. `/tmp/opencode/pr-body.json`
  containing `{"body": "..."}`) and pass it with `--input` rather than shell-quoting
  long Markdown.

- Issue title/body edits use the same pattern against `/repos/{owner}/{repo}/issues/<number>`.
- If any other `gh` GraphQL query fails with a Projects (classic) deprecation error,
  look up the equivalent REST endpoint with `gh api --help` or the docs and use that
  instead of retrying GraphQL.
