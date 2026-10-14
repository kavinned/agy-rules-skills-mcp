---
name: install-skills
description: Analyze workspace tech stack and tools, search available skills using bunx @rmyndharis/antigravity-skills, and install relevant skills one by one. Use whenever the user asks to "find skills", "install skills", "recommend skills", "setup skills for this project", or discover skills for the workspace.
---

# Install Skills

Inspect current workspace, search the Antigravity skills vault, and install matching skills for the project's stack.

## Workflow

### 1. Analyze Workspace
Inspect repository root and configuration files to identify languages, frameworks, and infrastructure:
- Node/TS: `package.json`, `tsconfig.json`
- Python: `pyproject.toml`, `requirements.txt`, `Pipfile`
- Rust/Go: `Cargo.toml`, `go.mod`
- Infra/DevOps: `Dockerfile`, `docker-compose.yml`, `.github/workflows`

Extract key search keywords (e.g., `react`, `typescript`, `python`, `docker`, `tailwind`, `prisma`).

### 2. Search Skills Vault
Find matching skills using the CLI:
- Keyword search: `bunx @rmyndharis/antigravity-skills search <query>`
- Full vault overview: `bunx @rmyndharis/antigravity-skills list`

Filter for skills that directly match active tools in the project. Skip unrelated or speculative skills.

### 3. Install Skills Sequentially
The `install` command only accepts a single skill per invocation. Iterate over the resolved skill list:

**Workspace install (default):**
```bash
# PowerShell
@("skill-1", "skill-2") | ForEach-Object { bunx @rmyndharis/antigravity-skills install $_ }

# Bash
for skill in skill-1 skill-2; do bunx @rmyndharis/antigravity-skills install "$skill"; done
```

**Global install (when user explicitly requests global/cross-project skills):**
```bash
# PowerShell
@("skill-1", "skill-2") | ForEach-Object { bunx @rmyndharis/antigravity-skills install -g $_ }

# Bash
for skill in skill-1 skill-2; do bunx @rmyndharis/antigravity-skills install -g "$skill"; done
```

### 4. Verify
List installed skills to confirm:
- Workspace: `bunx @rmyndharis/antigravity-skills installed`
- Global: inspect `~/.gemini/antigravity/skills` or `~/.gemini/config/skills`

Report installed skills back to user with brief rationale for each.
