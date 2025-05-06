#!/bin/bash

# 任務更新腳本
# 使用方法: ./scripts/update_task.sh <任務編號> <狀態>
# 狀態: pending (未開始), in-progress (進行中), completed (已完成)

TASK_FILE="TASK.md"
TASK_NUMBER=$1
STATUS=$2

if [ -z "$TASK_NUMBER" ] || [ -z "$STATUS" ]; then
  echo "使用方法: ./scripts/update_task.sh <任務編號> <狀態>"
  echo "狀態: pending (未開始), in-progress (進行中), completed (已完成)"
  exit 1
fi

case $STATUS in
  "pending")
    NEW_STATUS="[ ]"
    ;;
  "in-progress")
    NEW_STATUS="[🔄]"
    ;;
  "completed")
    NEW_STATUS="[x]"
    ;;
  *)
    echo "錯誤: 無效的狀態。請使用 pending, in-progress 或 completed"
    exit 1
    ;;
esac

# 使用 sed 更新任務狀態
if [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS 版本
  sed -i '' "s/- \[.\] 任務$TASK_NUMBER:/- $NEW_STATUS 任務$TASK_NUMBER:/" $TASK_FILE
else
  # Linux 版本
  sed -i "s/- \[.\] 任務$TASK_NUMBER:/- $NEW_STATUS 任務$TASK_NUMBER:/" $TASK_FILE
fi

echo "任務 $TASK_NUMBER 狀態已更新為 $STATUS" 