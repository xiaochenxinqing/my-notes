# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库性质

这是一个个人中文技术笔记仓库（Markdown 文档集），不是软件项目。没有构建、Lint 或测试流程；`package.json` 中的 `@playwright/test` 仅用于浏览器自动化工具（Playwright MCP），与笔记内容无关。

## 同步工作流

仓库通过根目录的 `GitSync.bat` 同步到 GitHub（`xiaochenxinqing/my-notes`，main 分支），其内容为 `git add -A` → `git commit -m "save"` → `git pull` → `git push`。本仓库的提交信息惯例是 "save"。

## 目录组织

顶层目录按字母前缀排序分类，新笔记按主题放入对应目录：

- `A大纲/` — 学习路线、面试题、技术总览类大纲
- `B后端/` — Java 后端、Spring、Redis、并发等
- `C前端/` — 前端（Vue、jQuery 等）
- `D工具/` — 开发工具（Git、Maven、命令行等）
- `E运维/` — Linux、Nginx、Docker、网络抓包等
- `Y渔翁/` — 密码学、数据库安全等专题
- `Z其他/` — 非技术杂项
- `区块链/`、`数据库/` — 按主题独立成目录

## 笔记约定

- 正文使用简体中文，Markdown 文件统一 UTF-8（无 BOM）
- 图片放在笔记所在目录的 `image/`（部分目录为 `assets/`）子目录中，在笔记内用相对路径引用
- 文件名常含中文、空格及特殊字符（如 `##mysql_查询TIPS.md`），在 shell 中操作时必须用双引号包裹路径

## 行尾符

`.gitattributes` 规定：`*.bat` 使用 CRLF，`*.sh` 使用 LF。创建脚本时保持对应行尾符。
