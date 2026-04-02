#!/usr/bin/env bash
# ============================================================
# 检测当前 agent 环境，返回 skill 存储根路径
# 用法: bash scripts/detect_env.sh
# 返回: 输出 skill 根路径到 stdout
# ============================================================

set -euo pipefail

detect_skill_root() {
  local found=()

  # 按优先级检测已知环境
  if [ -d ".kiro/skills" ]; then
    found+=(".kiro/skills")
  fi

  if [ -d ".agents/skills" ]; then
    found+=(".agents/skills")
  fi

  if [ -d ".cursor/skills" ]; then
    found+=(".cursor/skills")
  fi

  case ${#found[@]} in
    0)
      echo "[detect_env] 未检测到已知 agent 环境" >&2
      echo "[detect_env] 已知环境: .kiro/skills, .agents/skills, .cursor/skills" >&2
      echo "[detect_env] 请手动指定 skill 存储路径" >&2
      exit 1
      ;;
    1)
      echo "${found[0]}"
      ;;
    *)
      echo "[detect_env] 检测到多个 agent 环境:" >&2
      for i in "${!found[@]}"; do
        echo "  [$((i+1))] ${found[$i]}" >&2
      done
      echo "[detect_env] 请手动指定要使用的路径" >&2
      # 默认返回第一个找到的
      echo "${found[0]}"
      ;;
  esac
}

detect_skill_root
