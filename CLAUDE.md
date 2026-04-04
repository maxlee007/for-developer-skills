# CLAUDE.md

为 Claude Code 在此仓库工作提供指导。

## 项目

Claude Code 技能仓库，包含三个互联的技能，用于系统性地分析和理解任何代码库。

## 三个技能

### 1. codebase-overview
全景分析，生成 `.code-insight/main.md`，包含架构、技术栈、数据流、模块地图。

### 2. codebase-deep-dive
模块深潜，需在 codebase-overview 之后运行。生成详细的模块分析文档。

### 3. super-design
工作流编排，使用 Superpowers，UI/UX 由 ui-ux-pro-max-skill 负责。

## 开发技能时必须遵守

### Mermaid 图表规则
- 包含中文、空格、特殊字符的标签必须加引号：`A["标签"]`
- 用 `-->` 表示边，禁止用 `---`
- subgraph 嵌套不超过 2 层
- 所有 subgraph 必须有对应的 `end`
- 高对比度颜色突出当前模块

### 技能交互
- codebase-overview 生成的模块表生成映射给 codebase-deep-dive 使用
- 两个都可交由 super-design 处理

### 模板一致性
- 每个技能的 SKILL.md 包含 YAML frontmatter、工作流阶段、输出模板
- 保持各技能间的结构一致性
- 中文编写，简洁无冗余
