---
name: sandbox-setup
description: 一键为当前项目开启 Claude Code 沙箱模式，大幅减少开发过程中的权限确认弹窗，让编码流程不再被打断。支持团队共享和仅本机生效两种模式。当用户提到"沙箱模式"、"sandbox"、"减少确认"、"不要老问我"、"自动批准"、"少打扰"、"初始化项目配置"、"设置权限"、"setup sandbox"、"init sandbox"时，务必使用此 skill。即使用户只是抱怨 Claude Code 确认太多、操作老被打断，也应该主动建议使用此 skill。
disable-model-invocation: true
---

# Sandbox Setup Skill

为当前项目一键生成沙箱模式配置，核心效果：沙箱内 Bash 命令全部自动放行，只对沙箱外的命令（docker/git）和 WebFetch/MCP 做显式授权。

## 执行步骤

### 1. 确认项目根目录

在当前工作目录下操作。如果用户指定了其他路径，切到那个路径。

### 2. 选择配置模式

**在执行任何操作之前**，先询问用户选择配置模式：

- **团队共享模式** → 生成 `.claude/settings.json`
  - 可以提交到 Git，团队成员拉取代码后自动共享同一套沙箱配置
  - 适合：团队统一开发规范、CI/CD 环境

- **仅我使用模式** → 生成 `.claude/settings.local.json`
  - Claude Code 约定 `settings.local.json` 不会被提交到版本控制（应加入 .gitignore）
  - 适合：个人偏好配置、本机特有的 MCP 插件或域名白名单
  - 优先级高于 `settings.json`，可以覆盖团队共享配置

用简洁的方式询问，例如：

> 请选择配置模式：
>
> 1. **团队共享** — 生成 `settings.json`，提交到 Git 后团队共用
> 2. **仅我使用** — 生成 `settings.local.json`，不进版本控制，只在本机生效

如果用户在触发 skill 时已经明确说了（比如"给我个人用的沙箱配置"），就不需要再问，直接用对应模式。

### 3. 运行配置脚本

根据用户选择的模式，传入参数：

```bash
# 团队共享模式
bash <skill_path>/scripts/setup.sh shared

# 仅我使用模式
bash <skill_path>/scripts/setup.sh local
```

脚本会：

- 创建 `.claude/` 目录（如果不存在）
- 根据模式生成 `settings.json` 或 `settings.local.json`
- 如果目标文件已存在，备份为 `.bak.{timestamp}`
- 如果选择了「仅我使用」模式，自动确保 `.claude/settings.local.json` 在 `.gitignore` 中

### 4. 询问用户是否需要定制

配置生成后，检查用户是否有额外需求：

- **额外的 `excludedCommands`**：比如 `kubectl`、`ssh`、`aws` 等需要访问宿主机的命令。如果添加了，同时要在 `permissions.allow` 里加对应的 `Bash(xxx *)` 规则
- **额外的 WebFetch 域名**：比如公司内部文档站、私有 registry 等
- **额外的 MCP 插件**：用户安装的其他插件，格式为 `mcp__<server_id>` 或 `mcp__<server_id>__<tool>`
- **defaultMode 切换**：如果是 Docker 隔离环境，可以直接用 `bypassPermissions`

根据用户回答，使用编辑工具修改生成的配置文件。

### 5. 完成

告诉用户：重新启动 Claude Code（或在当前会话中输入 `/permissions` 验证）即可生效。

如果选择了团队共享模式，提醒用户提交 `.claude/settings.json` 到 Git。
