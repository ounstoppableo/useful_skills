#!/usr/bin/env bash
# ============================================================
# learn-project skill 文件操作脚本
# 所有对 learning_cornerstone/ 的文件操作通过此脚本完成，
# 不依赖特定 agent 的内置文件工具。
# ============================================================

set -euo pipefail

OUTPUT_DIR="learning_cornerstone"

usage() {
  cat << 'EOF'
用法: bash scripts/file_ops.sh <command> [args...]

命令:
  init                          初始化输出目录
  clean                         清理并重建输出目录
  write  <filename> <content>   写入文档（覆盖）
  append <filename> <content>   追加内容到文档
  delete <filename>             删除单个文档
  list                          列出所有已生成文档

示例:
  bash scripts/file_ops.sh init
  bash scripts/file_ops.sh write 01-overview.md "# 项目概览"
  bash scripts/file_ops.sh append 07-qa-notes.md "### Q: 问题"
  bash scripts/file_ops.sh delete 05-deep-dive.md
  bash scripts/file_ops.sh clean
EOF
}

cmd_init() {
  mkdir -p "$OUTPUT_DIR"
  echo "[learn-project] 已初始化目录: $OUTPUT_DIR/"
}

cmd_clean() {
  rm -rf "$OUTPUT_DIR"
  mkdir -p "$OUTPUT_DIR"
  echo "[learn-project] 已清理并重建目录: $OUTPUT_DIR/"
}

cmd_write() {
  local filename="$1"
  local content="$2"
  mkdir -p "$OUTPUT_DIR"
  printf '%s\n' "$content" > "$OUTPUT_DIR/$filename"
  echo "[learn-project] 已写入: $OUTPUT_DIR/$filename"
}

cmd_append() {
  local filename="$1"
  local content="$2"
  mkdir -p "$OUTPUT_DIR"
  printf '\n%s\n' "$content" >> "$OUTPUT_DIR/$filename"
  echo "[learn-project] 已追加到: $OUTPUT_DIR/$filename"
}

cmd_delete() {
  local filename="$1"
  rm -f "$OUTPUT_DIR/$filename"
  echo "[learn-project] 已删除: $OUTPUT_DIR/$filename"
}

cmd_list() {
  if [ -d "$OUTPUT_DIR" ]; then
    echo "[learn-project] 已生成文档:"
    ls -1 "$OUTPUT_DIR/" 2>/dev/null || echo "  (空)"
  else
    echo "[learn-project] 输出目录不存在，请先执行 init"
  fi
}

# ---- 主入口 ----
if [ $# -lt 1 ]; then
  usage
  exit 1
fi

command="$1"
shift

case "$command" in
  init)   cmd_init ;;
  clean)  cmd_clean ;;
  write)  cmd_write "$1" "$2" ;;
  append) cmd_append "$1" "$2" ;;
  delete) cmd_delete "$1" ;;
  list)   cmd_list ;;
  -h|--help) usage ;;
  *)
    echo "未知命令: $command"
    usage
    exit 1
    ;;
esac
