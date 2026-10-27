# Clarify First

智能体交互规范 skill：当存在不确定背景、缺少关键上下文、或需要人工查询/确认数据时，暂停生成，向用户提出聚焦的澄清问题并等待答复，而不是输出覆盖多种假设的大而全方案。

## 支持的平台

| 平台 | 格式 | 安装方式 |
|---|---|---|
| **Codex** | `SKILL.md`（skills 目录） | `./install.sh codex` |
| **Claude Code** | `SKILL.md`（同格式） | `./install.sh claude` |
| **OpenCode** | `AGENTS.md` | `./install.sh opencode` |
| **Pi** | 复制到项目目录后手动放置 | `./install.sh pi` |

## 快速安装

```bash
git clone https://github.com/gcsun/clarify-first.git
cd clarify-first
./install.sh          # 自动检测已安装的平台
./install.sh claude   # 指定平台
```

## 手动安装

### Codex
```bash
cp -r clarify-first ~/.codex/skills/
```

### Claude Code
```bash
cp -r clarify-first ~/.claude/skills/
```

### OpenCode
将 `clarify-first/SKILL.md` 内容追加到项目根目录的 `AGENTS.md` 中，或使用安装脚本自动追加。

### Pi / 其他平台
`SKILL.md` 是自包含的 markdown 文件，将其内容作为 system prompt 的一部分或规则文件注入即可。核心内容不依赖任何特定平台的 API 或工具。

## 仓库结构

```
clarify-first/
├── SKILL.md                        # 核心规则（所有平台通用）
├── references/
│   ├── decision-criteria.md        # 边界判定
│   └── examples.md                 # 改写示例
├── install.sh                      # 通用安装脚本
├── README.md
└── .gitignore
```

## 为什么跨平台兼容

`SKILL.md` 的内容是纯 markdown 行为指令：
- 不调用任何平台特定 API
- 不依赖特定工具链
- YAML frontmatter 仅包含 `name` 和 `description`（多数平台通用）
- 所有规则通过自然语言表达，任何 LLM 都能理解并遵循

唯一需要适配的是**安装位置**，而非内容本身。
