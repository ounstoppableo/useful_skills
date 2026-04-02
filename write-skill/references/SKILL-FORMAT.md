# SKILL.md 编写格式

## Frontmatter（必须）

```yaml
---
name: your-skill          # 必填。短横线分隔，小写
description: >            # 必填。自动激活的匹配依据
  一句话说明技能覆盖什么、什么时候用。
  包含关键文件名和触发关键词。
user-invocable: true      # 可选。是否在用户菜单中显示（默认 true）
---
```

## Description 写法

description 是 agent 决定是否自动加载 skill 的关键依据。要包含：

1. 技能覆盖的主题
2. 触发场景（用户会说什么话）
3. 涉及的关键文件名
4. 相关关键词

```yaml
# 差：太模糊，无法自动匹配
description: 帮助写文档。

# 好：具体场景 + 关键词 + 文件名
description: >
  通用项目学习技能。当用户说"帮我学习这个项目"、"分析架构"时使用。
  输出到 learning_cornerstone/，涉及 README、package.json、Dockerfile 等。
```

## 正文结构

```markdown
# 技能名称

（一句话说明：什么时候用这个 skill）

## 核心概念
（如有必要，解释关键术语或前置知识）

## 执行流程
（分步骤描述 agent 该做什么，这是 SKILL.md 的核心部分）

## 执行规则
（约束条件、边界情况、注意事项）
```

## 写作原则

1. 告诉 agent 该"做什么"，而不是"知道什么"
2. 用"Use this skill when..."开头
3. 包含可直接执行的步骤
4. 引用子文件而不是内联大段内容
5. 控制在 200 行以内，超过则拆分

## 引用子文件的方式

```markdown
文件操作参见 `scripts/file_ops.sh`。
文档格式参见 `references/DOC-FORMAT.md`。
配置参数参见 `metadata/config.json`。
```
