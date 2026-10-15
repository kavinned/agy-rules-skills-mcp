---
name: install-skills
description: Analyze workspace tech stack and tools, search available skills using bunx @rmyndharis/antigravity-skills (or fallback to bunx skills find), and install strictly necessary skills without causing bloat. Use whenever the user asks to "find skills", "install skills", "recommend skills", "setup skills for this project", or discover skills for the workspace.
---

# Install Skills

Inspect current workspace, search the Antigravity skills vault (with fallback to the broader skills registry), and install only strictly necessary skills for the project's stack.

## Core Rule: Avoid Bloat
- **Install only what is strictly necessary**: Never install speculative, redundant, or marginally related skills.
- **Keep the agent lean**: Every installed skill consumes context. Choose the single best-fitting skill over multiple overlapping ones.

## Workflow

### 1. Analyze Workspace
Inspect repository root and configuration files to identify languages, frameworks, and infrastructure:
- Node/TS: `package.json`, `tsconfig.json`
- Python: `pyproject.toml`, `requirements.txt`, `Pipfile`
- Rust/Go: `Cargo.toml`, `go.mod`
- Infra/DevOps: `Dockerfile`, `docker-compose.yml`, `.github/workflows`

Extract key search keywords (e.g., `react`, `typescript`, `python`, `docker`, `tailwind`, `prisma`).

### 2. Search Skills Vault

#### Primary: Antigravity Skills Vault
Search the curated Antigravity repository first:
- Keyword search: `bunx @rmyndharis/antigravity-skills search <query>`
- Full vault overview: `bunx @rmyndharis/antigravity-skills list`

Filter for skills that directly match active tools in the project. Skip unrelated or speculative skills.

#### Fallback: Broader Skills Registry (`bunx skills find`)
If a suitable skill cannot be found in the primary vault, search the broader registry:
- Search: `bunx skills find <query>`
- Check repo details: `bunx skills find <query> --json`

### 3. Install Necessary Skills Sequentially
Install only the confirmed, necessary skills. Do not bulk-install speculative packages.

**From Primary Vault (`@rmyndharis/antigravity-skills`):**
- Workspace install (default):
  ```bash
  # PowerShell
  @("skill-1", "skill-2") | ForEach-Object { bunx @rmyndharis/antigravity-skills install $_ }

  # Bash
  for skill in skill-1 skill-2; do bunx @rmyndharis/antigravity-skills install "$skill"; done
  ```
- Global install (when explicitly requested):
  ```bash
  # PowerShell
  @("skill-1", "skill-2") | ForEach-Object { bunx @rmyndharis/antigravity-skills install -g $_ }

  # Bash
  for skill in skill-1 skill-2; do bunx @rmyndharis/antigravity-skills install -g "$skill"; done
  ```

**From Fallback Registry (`bunx skills add`):**
- Project install:
  ```bash
  bunx skills add <owner/repo> -y
  ```
- Global install:
  ```bash
  bunx skills add <owner/repo> -g -y
  ```

### 4. Verify
List installed skills to confirm:
- Primary vault workspace: `bunx @rmyndharis/antigravity-skills installed`
- General skills registry: `bunx skills list`
- Global: inspect `~/.gemini/antigravity/skills` or `~/.gemini/config/skills`

Report installed skills back to user with brief rationale for each, confirming no redundant bloat was added.

