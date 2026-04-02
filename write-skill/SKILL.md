---
name: write-skill
description: >
  Skill 编写规范。当需要创建新 skill、修改现有 skill、或者不确定 skill 该怎么组织时使用。
  涵盖目录结构、SKILL.md 编写、frontmatter 字段、description 写法、
  scripts 脚本规范、references 参考资料、metadata 元数据、命名约定等。
  关键路径：.kiro/skills/
user-invocable: true
---

# Skill 编写规范

当你需要创建或修改 `.kiro/skills/` 下的 skill 时，使用此规范。

## 何时创建 Skill

创建 skill 的场景：
- 多步骤工作流（需要明确的执行顺序和步骤）
- 需要配套脚本或参考资料的复杂任务
- 特定领域的专业知识（只在相关任务时加载）
- 可复用的操作模板（跨项目通用）

不需要 skill 的场景：
- 一句话就能说清的规则（放 steering 里）
- 每次会话都需要的通用约束（放 steering 里）

## 标准目录结构

```
.kiro/skills/
└── your-skill/
    ├── SKILL.md              # 必须：核心技能定义
    ├── scripts/              # 可选：资源脚本
    │   └── file_ops.sh       #   文件操作、初始化、清理等
    ├── references/           # 可选：参考资料
    │   └── CONVENTIONS.md    #   格式规范、模板、示例
    └── metadata/             # 可选：元数据
        └── config.json       #   版本、配置项、结构化参数
```

### 各目录职责

| 目录 | 职责 | 放什么 |
|------|------|--------|
| `SKILL.md` | 核心定义 | frontmatter + 执行流程 + 规则 |
| `scripts/` | 可执行脚本 | shell 脚本、文件操作、初始化/清理 |
| `references/` | 参考资料 | 格式规范、模板、约定、示例 |
| `metadata/` | 元数据 | 版本号、配置参数、结构化定义 |

### 拆分原则

SKILL.md 只保留 agent 执行时必须知道的内容。其他外置：

- 具体的文件操作命令 → `scripts/`
- 输出格式规范、模板 → `references/`
- 版本号、可配置参数 → `metadata/`

SKILL.md 中通过"参见 `scripts/xxx.sh`"引用子文件。

## SKILL.md 编写规范

详见 `references/SKILL-FORMAT.md`。

## scripts/ 编写规范

详见 `references/SCRIPTS-FORMAT.md`。

## references/ 与 metadata/ 规范

详见 `references/EXTRAS-FORMAT.md`。

## 命名约定

- skill 目录名：短横线分隔，小写，主题导向
  - 好：`learn-project`、`code-review`、`api-scaffold`
  - 差：`my_skill`、`SkillForLearning`、`v2-new-skill`
- 脚本文件名：`snake_case.sh`
- 参考文档名：`UPPER-KEBAB.md`
- 元数据文件名：`config.json`

## 执行流程：创建新 Skill

1. 确定 skill 名称（短横线小写）
2. 创建目录：`mkdir -p .kiro/skills/{name}`
3. 编写 `SKILL.md`（frontmatter + 执行流程 + 规则）
4. 如需文件输出 → 创建 `scripts/file_ops.sh`
5. 如需格式规范 → 创建 `references/` 下的文档
6. 如需配置参数 → 创建 `metadata/config.json`
7. 用自检清单验证

## 自检清单

- [ ] SKILL.md 有 `name` 和 `description` frontmatter
- [ ] description 包含触发场景和关键词
- [ ] 执行流程步骤清晰，agent 能直接照做
- [ ] 文件操作通过 scripts/ 脚本完成（如需要）
- [ ] 格式规范抽到 references/（如需要）
- [ ] 可配置参数放到 metadata/（如需要）
- [ ] SKILL.md 不超过 200 行（超过则拆分到子文件）
- [ ] 目录名和文件名符合命名约定
