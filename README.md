# Claude Code — Wiz CLI Skill

Claude Code skill for local security scanning via Wiz CLI (`wizcli`). Scans code, directories, container images, and IaC files with service account authentication.

## What This Does

Bundles `wizcli` into a Claude Code skill so you can say "scan this directory for vulnerabilities" or "scan this Docker image" and it runs a full Wiz security scan locally.

## Prerequisites

- A `~/.wiz-token` file with your Wiz service account credentials:

```
id:<your-client-id>
secret:<your-client-secret>
api: https://api.<dc>.app.wiz.io/graphql
auth:https://auth.app.wiz.io/oauth/token
```

## Installation

### 1. Copy skill files

```bash
mkdir -p ~/.claude/skills/wizcli
cp SKILL.md run-wizcli.sh ~/.claude/skills/wizcli/
chmod +x ~/.claude/skills/wizcli/run-wizcli.sh
```

### 2. Download wizcli binary

```bash
# Apple Silicon Mac
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-darwin-arm64

# Intel Mac
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-darwin-amd64

# Linux x86_64
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-linux-amd64

# Linux ARM64
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-linux-arm64

chmod +x ~/.claude/skills/wizcli/wizcli
```

### 3. Verify

```bash
~/.claude/skills/wizcli/run-wizcli.sh version
```

## Usage

In Claude Code, say things like:

- "scan this directory for vulnerabilities"
- "scan the current project for secrets"
- "scan this Docker image"
- "scan our Terraform files"

Or invoke directly: `/wizcli`

### Scan Types

```bash
# Directory / code scan
~/.claude/skills/wizcli/run-wizcli.sh scan dir <path> --no-publish

# Container image scan
~/.claude/skills/wizcli/run-wizcli.sh scan image <image:tag>

# IaC scan (Terraform, CloudFormation, K8s)
~/.claude/skills/wizcli/run-wizcli.sh scan iac --path <path>

# Secrets only
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --disabled-scanners=Vulnerability,Misconfiguration,SoftwareSupplyChain,AIModels,SAST,Malware --no-publish
```

### Options

- `--no-publish` — local-only scan, don't upload results to Wiz portal
- `--format json` — JSON output for parsing
- `--disabled-scanners=<list>` — skip specific scanners

## Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Skill definition — tells Claude when/how to use wizcli |
| `run-wizcli.sh` | Wrapper script — reads `~/.wiz-token`, exports creds, runs wizcli |
| `wizcli` | Binary (not in repo — download per install instructions above) |

## Updating wizcli

```bash
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-darwin-arm64
chmod +x ~/.claude/skills/wizcli/wizcli
```

## Security

- No credentials are stored in this repo
- The `wizcli` binary is gitignored (327MB, download separately)
- Credentials are read from `~/.wiz-token` at runtime
