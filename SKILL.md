---
name: wizcli
description: Use when the user asks to "scan code", "scan directory", "scan container", "scan image",
  "scan IaC", "scan terraform", "scan dockerfile", "wizcli scan", "wiz scan", "security scan with wiz",
  "scan for secrets", "scan for vulnerabilities", or wants to run local security scans via Wiz CLI.
---

# Wiz CLI Security Scanner

Scan local code, directories, container images, and IaC files using wizcli with service account auth from `~/.wiz-token`.

## Wrapper Script

All commands go through the wrapper which handles auth automatically:

```bash
~/.claude/skills/wizcli/run-wizcli.sh <command> [args...]
```

## Scan Types

### Directory / Code Scan

Scan a local directory for vulnerabilities, secrets, misconfigurations, and malware:

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir <path>
```

Options:
- `--no-publish` — local-only scan, don't upload results to Wiz portal
- `--policy <name>` — apply a specific Wiz policy
- `--disabled-scanners=<list>` — skip specific scanners (comma-separated: Vulnerability, SensitiveData, Misconfiguration, SoftwareSupplyChain, AIModels, SAST, Malware)
- `--format json` — output as JSON for parsing

### Container Image Scan

Scan a local or registry container image:

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan image <image:tag>
```

### IaC Scan (Terraform, CloudFormation, Kubernetes)

Scan Infrastructure as Code files:

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan iac --path <path>
```

### Docker Compose Scan

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan docker-compose --file <path>
```

## Common Patterns

**Full scan of current directory:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --no-publish
```

**Scan only for secrets:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --disabled-scanners=Vulnerability,Misconfiguration,SoftwareSupplyChain,AIModels,SAST,Malware --no-publish
```

**Scan and publish to Wiz portal:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir .
```

**JSON output for parsing:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --no-publish --format json
```

## Limitations

- Binary is bundled at `~/.claude/skills/wizcli/wizcli` (v1.37.0, darwin-arm64)
- Auth uses service account from `~/.wiz-token` (client credentials flow)
- Large scans may take several minutes
- `--no-publish` recommended for local development; omit to send results to Wiz portal

## Updating wizcli

```bash
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-darwin-arm64
chmod +x ~/.claude/skills/wizcli/wizcli
```
