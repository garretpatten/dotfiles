# Git hooks

This directory contains shared Git hooks. They are meant to be referenced from a
single location on your machine so every repository that uses them stays in
sync.

## Pre-commit hook

The `pre-commit` hook scans staged changes with
[betterleaks](https://betterleaks.com) for verified secrets. If a verified
secret is found, the commit is blocked and the affected file path is printed.

The hook is intentionally defensive:

- If betterleaks is missing, it tries to install it via `dnf`, `yay`, `brew`,
  or `go install`, or on Windows via `winget`.
- If no supported package manager is available, or the install fails, the hook
  passes with a warning instead of blocking the commit.
- If betterleaks errors for any reason other than finding a verified secret,
  the hook passes and prints the error output.

On Windows Git Bash, MSYS, or Cygwin, the bash `pre-commit` hook delegates to
`pre-commit.ps1`, which installs and runs betterleaks via PowerShell and winget.

## Where to place the hook

Copy or symlink this directory so the hook lives at:

```text
$HOME/.config/githooks/pre-commit
```

Example from the repository root:

```bash
mkdir -p "$HOME/.config/githooks"
cp config/githooks/pre-commit "$HOME/.config/githooks/pre-commit"
chmod +x "$HOME/.config/githooks/pre-commit"
```

## Configure Git to run the hook

Point Git at the shared hooks directory. From a repository that should use the
hook, run:

```bash
git config --local core.hooksPath "$HOME/.config/githooks"
```

Verify it runs:

```bash
git hook run pre-commit
```

## Add to existing pre-commit hooks

If a repository already has a `pre-commit` hook in `.git/hooks/pre-commit`, you
can chain this hook from it. Keep your existing logic and add the shared hook at
the end:

```bash
# At the bottom of .git/hooks/pre-commit
"$HOME/.config/githooks/pre-commit" || exit $?
```

Or, if your existing hook is a script, source it in place:

```bash
# At the bottom of .git/hooks/pre-commit
source "$HOME/.config/githooks/pre-commit"
```

Make sure the existing hook exits non-zero before the shared hook if you want
earlier checks to block the commit without running the betterleaks scan.
