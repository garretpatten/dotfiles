# apt snapshot cooldown kit

Holds apt on the official Ubuntu archive as it was 7 days ago, so packages
younger than the cooldown never reach `apt`, `apt-get`, or
`unattended-upgrades`. Uses the official Ubuntu Snapshot Service
([snapshot.ubuntu.com]), not a third-party mirror. Covers all
snapshot-capable repositories, including the security pocket; repositories
without snapshot support (vendor repos, ESM) stay live.

[snapshot.ubuntu.com]: https://snapshot.ubuntu.com/

## Files

- `apt-cooldown-snapshot` — root-owned script; writes `APT::Snapshot` to
  `/etc/apt/apt.conf.d/99-cooldown-snapshot` (now minus 7 days, noon UTC) and
  refreshes indexes.
- `apt-cooldown-snapshot.service` — oneshot unit wrapping the script.
- `apt-cooldown-snapshot.timer` — daily at 04:45 with 15 minutes of jitter,
  ahead of the unattended-upgrades window.

## Installation

```sh
install -m 755 apt-cooldown-snapshot /usr/local/sbin/
install -m 644 apt-cooldown-snapshot.service /etc/systemd/system/
install -m 644 apt-cooldown-snapshot.timer /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now apt-cooldown-snapshot.timer
```

The first run performs the initial roll and `apt-get update`; the next
upgrade pulls the accumulated 7-day backlog.

## Notes

- Requires Ubuntu 24.04+ `apt`, which auto-detects snapshot-capable
  repositories via the `Snapshots:` field in their Release files.
- Override a single run with `apt install <pkg> --snapshot <id>`, or remove
  `/etc/apt/apt.conf.d/99-cooldown-snapshot` to opt out.
