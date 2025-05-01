# Bash Backup Tool

A simple, rsync-based backup script with logging and dry-run 

## Features

- Uses `rsync` for fast, incremental backups
- Daily logs
- Dry-run mode by default (safe!)
- Locking to prevent concurrent runs

## Usage

```bash
./backup.sh <source_dir> <target_dir> [--real-run]
```

## Options

| Option       | Description                                                                      |
| ------------ | -------------------------------------------------------------------------------- |
| `--real-run` | Disables dry-run mode. Files will actually be copied/deleted.                    |
| _(none)_     | Default is dry-run mode. Shows what changes would be made without applying them. |

