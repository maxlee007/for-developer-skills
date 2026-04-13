#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-shared}"
CLAUDE_DIR=".claude"

if [ "${MODE}" = "local" ]; then
  SETTINGS_FILE="${CLAUDE_DIR}/settings.local.json"
  MODE_LABEL="仅我使用"
else
  SETTINGS_FILE="${CLAUDE_DIR}/settings.json"
  MODE_LABEL="团队共享"
fi

# Create .claude/ directory
mkdir -p "${CLAUDE_DIR}"

# Backup existing settings if present
if [ -f "${SETTINGS_FILE}" ]; then
  BACKUP="${SETTINGS_FILE}.bak.$(date +%Y%m%d%H%M%S)"
  cp "${SETTINGS_FILE}" "${BACKUP}"
  echo "⚠️  已备份现有配置到 ${BACKUP}"
fi

# Write settings
cat > "${SETTINGS_FILE}" << 'JSON'
{
  "permissions": {
    "allow": [
      "Bash(git *)",
      "Bash(docker *)",
      "Bash(docker-compose *)",
      "Bash(docker compose *)",
      "Bash(npm *)",
      "Bash(npx *)",
      "Bash(yarn *)",
      "Bash(pnpm *)",
      "Bash(pip *)",
      "Bash(pip3 *)",
      "Bash(poetry *)",
      "Bash(uv *)",
      "Bash(python *)",
      "Base(python3 *)",

      "WebFetch(domain:github.com)",
      "WebFetch(domain:raw.githubusercontent.com)",
      "WebFetch(domain:registry.npmjs.org)",
      "WebFetch(domain:pypi.org)",
      "WebFetch(domain:files.pythonhosted.org)",
      "WebFetch(domain:crates.io)",
      "WebFetch(domain:docs.rs)",
      "WebFetch(domain:pkg.go.dev)",
      "WebFetch(domain:developer.mozilla.org)",
      "WebFetch(domain:stackoverflow.com)",

      "mcp__plugin_context7_context7",
      "mcp__plugin_serena_serena",

      "Skill(commit-commands:*)"
    ],

    "deny": [
      "Bash(rm -rf /)",
      "Bash(rm -rf /*)",
      "Bash(rm -rf ~)",
      "Bash(rm -rf ~/*)",
      "Bash(sudo rm -rf *)"
    ],

    "defaultMode": "acceptEdits"
  },

  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "network": {
      "allowLocalBinding": true
    },
    "excludedCommands": [
      "docker",
      "git",
      "npm",
      "npx",
      "yarn",
      "pnpm",
      "pip",
      "pip3",
      "poetry",
      "uv"
    ]
  }
}
JSON

# For local mode, ensure .gitignore covers the local settings file
if [ "${MODE}" = "local" ]; then
  GITIGNORE=".gitignore"
  PATTERN=".claude/settings.local.json"
  if [ -f "${GITIGNORE}" ]; then
    if ! grep -qF "${PATTERN}" "${GITIGNORE}"; then
      echo "" >> "${GITIGNORE}"
      echo "# Claude Code local settings" >> "${GITIGNORE}"
      echo "${PATTERN}" >> "${GITIGNORE}"
      echo "📝 已将 ${PATTERN} 追加到 .gitignore"
    fi
  else
    echo "# Claude Code local settings" > "${GITIGNORE}"
    echo "${PATTERN}" >> "${GITIGNORE}"
    echo "📝 已创建 .gitignore 并添加 ${PATTERN}"
  fi
fi

echo ""
echo "✅ 沙箱配置已写入 ${SETTINGS_FILE} （${MODE_LABEL}模式）"
echo ""
echo "配置摘要："
echo "  • sandbox: enabled + autoAllowBashIfSandboxed"
echo "  • defaultMode: acceptEdits"
echo "  • excludedCommands: docker, git (已在 allow 中显式授权)"
echo "  • deny: rm -rf /, rm -rf ~ 等危险操作"
echo ""
echo "重启 Claude Code 或输入 /permissions 验证生效"