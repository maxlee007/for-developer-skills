# 代码库分析技能集

帮助开发者快速理解代码库、组织开发流程的 Claude Code 技能集合。

## 安装

快速安装：

```bash
npx skills add maxlee007/for-developer-skills
```

## 代码库分析

用来快速理解一个陌生的代码库，以及评估它是否值得使用。包含三个协作的技能：

- **codebase-overview** — 生成项目全景分析
- **codebase-deep-dive** — 深入分析具体模块
- **project-evaluation** — 从使用者视角评估项目价值，含竞品对比

### 使用方式

1. 打开或下载一个代码库
2. 运行 **codebase-overview** 生成项目全景分析
3. 根据需要运行 **codebase-deep-dive** 深入研究某个具体模块
4. 运行 **project-evaluation** 评估项目是否值得使用（触发词：「项目评估」、「竞品分析」）

### 生成的文件

分析结果保存在对应目录中：

**`.code-insight/`**（代码分析）
- `main.md` — 项目全景分析，包含架构图、技术栈、数据流、模块地图
- `[module-name].md` — 具体模块的详细分析，包含 API 接口、内部设计、依赖关系

**`.project-eval/`**（项目评估）
- `main.md` — 多维度评分、竞品对比图、使用建议

所有文档都包含 Mermaid 图表，支持架构图、数据流图、模块依赖图等可视化。

## 开发工具

使用 **super-design** 组织完整的开发工作流程，集成 UI/UX 设计考虑。

此工具依赖：

- [superpowers](https://github.com/anthropics/superpowers)
- [ui-ux-pro-max-skill](https://github.com/anthropics/ui-ux-pro-max-skill)

## 特点

- 🎯 **智能分析** — 系统性地扫描和分析整个代码库
- 📊 **可视化图表** — 自动生成架构图、数据流图、模块依赖关系图
- 🔍 **多层次** — 从全局概览到模块深潜的多个分析层级
- 🌍 **支持多语言** — 可分析任何编程语言的代码库
- 📈 **可扩展** — 支持从小型项目到大型企业级代码库

## 文档

查看 `CLAUDE.md` 了解开发和维护这些技能的详细信息。
