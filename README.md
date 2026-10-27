# Clarify First

一个 Codex / 智能体交互规范 skill：当存在不确定背景、缺少关键上下文、或需要人工查询/确认数据时，暂停生成，向用户提出聚焦的澄清问题并等待答复，而不是输出覆盖多种假设的大而全方案。

## 安装

将 `clarify-first/` 文件夹复制到你的智能体 skills 目录下：

```bash
cp -r clarify-first ~/.codex/skills/
```

## 结构

```
clarify-first/
├── SKILL.md                        # 核心规则 + 触发判定 + 豁免 + 中断协议 + 禁止形态
├── agents/openai.yaml              # Codex UI 元数据
└── references/
    ├── decision-criteria.md        # 边界判定：三步流程 + 易误判 + 提问质量
    └── examples.md                 # 三类场景改写示例 + 反面速查 + 自检
```

## 适用场景

- 智能体遇到背景不确定、无法自行验证的知识
- 需要用户提供数据、配置、或业务规则
- 不可逆动作（删除、发布、付款）的关键参数未确认
- 用户目标存在多种合理解读，不同解读会导致完全不同的产出
