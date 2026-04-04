# 代码库分析技能集

帮助开发者系统性地理解和分析任何代码库的 Claude Code 技能集合。

## 项目介绍

本仓库包含三个互联的 Claude Code 技能，用于生成结构化的代码库分析文档：

### 1. 代码库全景分析 (codebase-overview)

快速了解整个项目的全貌。生成包含架构图、技术栈、数据流、模块地图等完整分析文档。

### 2. 模块深潜分析 (codebase-deep-dive)

深入研究项目中的某个具体模块。生成详细的模块文档，包括 API 接口、内部设计、依赖关系等。

### 3. 超级设计 (super-design)

使用 Superpowers 技能系统编排完整的开发工作流程，集成 UI/UX 设计考虑。

## 安装

使用 Claude Code 的技能管理工具安装此技能集：

```bash
npx skills add maxlee007/for-developer-skills
```

安装后在 Claude Code 中即可使用这三个技能。

### 前置要求

如果要使用 **super-design** 技能，还需要先安装以下依赖技能：

```bash
npx skills add anthropics/superpowers
npx skills add anthropics/ui-ux-pro-max-skill
```

codebase-overview 和 codebase-deep-dive 无需额外依赖。

## 使用方式

### 分析一个新项目

1. 打开或下载一个代码库
2. 在 Claude Code 中运行 **codebase-overview** 技能
3. 技能会生成 `.code-insight/main.md` 文件，包含完整的项目分析

### 深入了解某个模块

1. 首先运行 codebase-overview（如果还没有运行）
2. 在 Claude Code 中运行 **codebase-deep-dive** 技能
3. 选择要分析的模块，获得详细的模块文档

### 完整工作流程

使用 **super-design** 技能组织完整的开发流程，包括设计、规划、执行等阶段。

## 输出文档

所有分析结果保存在目标仓库的 `.code-insight/` 目录中：

- `main.md` — 项目全景分析（由 codebase-overview 生成）
- `[module-name].md` — 模块详细分析（由 codebase-deep-dive 生成）

文档包含 Mermaid 图表，支持架构图、数据流图、模块依赖图等可视化。

## 特点

- 🎯 **智能分析** — 系统性地扫描和分析整个代码库
- 📊 **可视化图表** — 自动生成架构图、数据流图、模块依赖关系图
- 🔍 **多层次** — 从全局概览到模块深潜的多个分析层级
- 🌍 **支持多语言** — 可分析任何编程语言的代码库
- 📈 **可扩展** — 支持从小型项目到大型企业级代码库

## 文档

查看 `CLAUDE.md` 了解开发和维护这些技能的详细信息。
