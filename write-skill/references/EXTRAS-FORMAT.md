# references/ 与 metadata/ 编写格式

## references/ 目录

存放 skill 执行时需要参考的静态文档。

### 适合放的内容

- 输出文档的格式模板
- 命名约定和风格规范
- 示例文档
- 领域知识参考

### 文件命名

大写短横线格式：`DOC-FORMAT.md`、`CONVENTIONS.md`、`EXAMPLES.md`

### 示例

```markdown
# 文档格式规范

## 文档结构模板

每个输出文档遵循以下结构：

（模板内容）

## 命名规则

（命名约定）
```

### 何时需要 references/

- skill 有明确的输出格式要求 → 需要
- skill 涉及特定领域的约定 → 需要
- skill 逻辑简单，无格式要求 → 不需要

---

## metadata/ 目录

存放结构化的配置参数和元信息。

### 标准 config.json 结构

```json
{
  "name": "skill-name",
  "version": "1.0.0",
  "description": "技能描述",
  "author": "author",
  "language": "zh-CN",
  "output_dir": "output_directory",
  "custom_config": {}
}
```

### 字段说明

| 字段 | 必填 | 说明 |
|------|------|------|
| `name` | 是 | 与 SKILL.md frontmatter 的 name 一致 |
| `version` | 是 | 语义化版本号 |
| `description` | 是 | 技能描述 |
| `author` | 否 | 作者 |
| `language` | 否 | 输出语言（默认 zh-CN） |
| `output_dir` | 否 | 输出目录路径（如有文件输出） |
| 其他自定义字段 | 否 | 根据 skill 需要自行扩展 |

### 何时需要 metadata/

- skill 有可配置的参数（阈值、目录名等） → 需要
- skill 需要版本管理 → 需要
- skill 简单且无可配置项 → 不需要
