# Cloudflare Pages 設置指南

按照以下步驟將您的 Flutter Web 作品集網站部署到 Cloudflare Pages：

## 1. 準備源代碼

確保您的代碼已推送到 GitHub 倉庫。Cloudflare Pages 可以直接從 GitHub 拉取代碼。

## 2. 登錄 Cloudflare Dashboard

訪問 [Cloudflare Dashboard](https://dash.cloudflare.com/) 並登錄您的賬戶。

## 3. 創建新的 Pages 項目

1. 點擊左側導航欄中的 "Pages"
2. 點擊 "Create a project" (創建項目)
3. 選擇 "Connect to Git" (連接到 Git)

## 4. 連接 GitHub 倉庫

1. 點擊 "Connect GitHub" 並授權 Cloudflare 訪問您的 GitHub 賬戶
2. 選擇包含您 Flutter Web 作品集的倉庫
3. 點擊 "Begin setup" (開始設置)

## 5. 配置構建設置

填寫以下設置：

- Project name (項目名稱): `joe-portfolio` (或您喜歡的名稱)
- Production branch (生產分支): `main` (或您的主分支名稱)
- Framework preset (框架預設): `None` (無)
- Build command (構建命令): `curl -fsSL https://github.com/kuanhoong/flutter_ci/raw/master/flutter_install.sh | bash -s 3.19.0 && flutter/bin/flutter build web --release`
- Build output directory (構建輸出目錄): `build/web`
- Root directory (根目錄): (留空，使用倉庫根目錄)

## 6. 環境變量設置 (如需要)

您可以添加以下環境變量以自定義構建過程：

- `FLUTTER_VERSION`: `3.19.0` (或您使用的 Flutter 版本)

## 7. 完成設置並部署

點擊 "Save and Deploy" (保存並部署)。Cloudflare 將開始構建和部署您的網站。

## 8. 查看構建狀態

您可以在 Cloudflare Pages 儀表板上實時監控構建過程。一旦構建成功，您將收到一個暫時的 URL (如 `https://your-project-name.pages.dev`)。

## 9. 自定義域名設置 (可選)

如果您想使用自己的域名：

1. 在 Pages 項目中點擊 "Custom domains" (自定義域名)
2. 點擊 "Set up a custom domain" (設置自定義域名)
3. 輸入您的域名並按照指示完成設置

## 10. 高級設置

### 特殊文件說明

我們已經在 `web` 目錄中添加了以下特殊文件，以增強在 Cloudflare Pages 上的體驗：

- `_routes.json`: 定義路由處理規則，確保客戶端路由正常工作
- `_headers`: 設置 HTTP 頭部，增強安全性和性能
- 修改後的 `index.html`: 包含更好的加載體驗
- 更新的 `manifest.json`: 改進 PWA 體驗

### 推送更新

每次推送到主分支時，Cloudflare Pages 都會自動重新構建和部署您的網站。

### 預覽分支

對於非主分支的推送，Cloudflare 會創建預覽部署，網址格式為 `https://branch-name.your-project-name.pages.dev`。

## 故障排除

- 如果構建失敗，請查看構建日誌以獲取詳細錯誤信息
- 確保 `web/index.html` 中的 `base href` 設置為 `/`
- 如果路由問題，檢查 `_routes.json` 文件
- 如果資源加載問題，檢查 `_headers` 文件中的 CSP 策略 