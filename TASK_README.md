# 任務追蹤系統

本專案使用 Cursor Rules 來追蹤任務完成情況。任務清單存儲在 `TASK.md` 文件中。

## 使用方法

### 查看任務

打開 `TASK.md` 文件查看所有任務及其狀態。

### 任務狀態標記

- `[ ]` 未開始
- `[🔄]` 進行中
- `[x]` 已完成

### 手動更新任務狀態

1. 打開 `TASK.md` 文件
2. 找到需要更新的任務
3. 修改任務前的狀態標記
4. 保存文件

### 使用腳本更新任務狀態

我們提供了一個腳本來快速更新任務狀態：

```bash
./scripts/update_task.sh <任務編號> <狀態>
```

狀態可以是：
- `pending` (未開始)
- `in-progress` (進行中)
- `completed` (已完成)

例如，將任務1標記為進行中：

```bash
./scripts/update_task.sh 1 in-progress
```

### 添加新任務

在 `TASK.md` 文件中的「待辦任務」部分添加新的任務項。使用格式：

```
- [ ] 任務X: 任務描述
```

### Cursor Rules

本項目使用 Cursor Rules 來幫助追蹤任務。AI 助手會自動檢查任務完成情況，並提供相應的建議。

規則細節在 `.cursor/rules/task-list.md` 文件中定義。 