# scripts/ 编写格式

## 设计原则

1. 所有文件操作通过 shell 脚本完成，不依赖特定 agent 的内置文件工具
2. 脚本自包含，`set -euo pipefail` 开头
3. 提供 `usage()` 帮助信息
4. 用子命令模式组织功能

## 标准模板

```bash
#!/usr/bin/env bash
# skill-name 文件操作脚本
set -euo pipefail

OUTPUT_DIR="your_output_dir"

usage() {
  cat << 'EOF'
用法: bash scripts/file_ops.sh <command> [args...]

命令:
  init                          初始化输出目录
  clean                         清理并重建输出目录
  write  <filename> <content>   写入文档（覆盖）
  append <filename> <content>   追加内容
  delete <filename>             删除文档
  list                          列出已生成文档
EOF
}

cmd_init() {
  mkdir -p "$OUTPUT_DIR"
  echo "[skill-name] 已初始化: $OUTPUT_DIR/"
}

cmd_clean() {
  rm -rf "$OUTPUT_DIR"
  mkdir -p "$OUTPUT_DIR"
  echo "[skill-name] 已清理重建: $OUTPUT_DIR/"
}

cmd_write() {
  mkdir -p "$OUTPUT_DIR"
  printf '%s\n' "$2" > "$OUTPUT_DIR/$1"
  echo "[skill-name] 已写入: $OUTPUT_DIR/$1"
}

cmd_append() {
  mkdir -p "$OUTPUT_DIR"
  printf '\n%s\n' "$2" >> "$OUTPUT_DIR/$1"
  echo "[skill-name] 已追加: $OUTPUT_DIR/$1"
}

cmd_delete() {
  rm -f "$OUTPUT_DIR/$1"
  echo "[skill-name] 已删除: $OUTPUT_DIR/$1"
}

cmd_list() {
  if [ -d "$OUTPUT_DIR" ]; then
    ls -1 "$OUTPUT_DIR/" 2>/dev/null || echo "  (空)"
  else
    echo "目录不存在，请先 init"
  fi
}

case "${1:-}" in
  init)   cmd_init ;;
  clean)  cmd_clean ;;
  write)  cmd_write "$2" "$3" ;;
  append) cmd_append "$2" "$3" ;;
  delete) cmd_delete "$2" ;;
  list)   cmd_list ;;
  *)      usage; exit 1 ;;
esac
```

## 使用方式

agent 在执行 skill 时，通过 shell 调用脚本：

```bash
# 初始化
bash .kiro/skills/your-skill/scripts/file_ops.sh init

# 写入文件
bash .kiro/skills/your-skill/scripts/file_ops.sh write "01-doc.md" "# 内容"

# 追加内容
bash .kiro/skills/your-skill/scripts/file_ops.sh append "notes.md" "新内容"
```

或者直接用 heredoc（不依赖脚本）：

```bash
mkdir -p output_dir
cat > output_dir/filename.md << 'EOF'
文档内容
EOF
```

## 何时需要 scripts/

- skill 需要创建/修改/删除文件 → 需要
- skill 只是提供指导信息，不产生文件输出 → 不需要
