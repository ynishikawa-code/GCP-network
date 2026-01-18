# 🏰 設計書：GCP Rocky Linux Webサーバー最小構成

## 🎯 ゴール

- GCP上に Rocky Linux 9 の Webサーバーを1台構築（Terraform）
- nginx を Ansible でインストール・起動・設定
- 外部IPから HTTP アクセス可能（index.html を表示）

---

## 🗺️ 1. インフラ構成図（テキスト）

```text
┌─────────────────────────────┐
│         GCP Project         │
│                             │
│  ┌───────────────┐          │
│  │     VPC        │          │
│  │  (custom VPC)  │          │
│  │               │          │
│  │  ┌─────────┐  │          │
│  │  │ Subnet   │  │          │
│  │  │ 10.0.1.0/24 │          │
│  │  └────┬──────┘  │         │
│  │       │          │         │
│  │  ┌────▼────────────┐      │
│  │  │ Compute Engine  │      │
│  │  │ Rocky Linux 9   │      │
│  │  │ nginx installed │      │
│  │  └────┬────────────┘      │
│  │       │                   │
│  │  ┌────▼────┐              │
│  │  │ External │              │
│  │  │ IP       │ ◀── HTTP ── │
│  │  └──────────┘              │
│  └───────────────────────────┘
└─────────────────────────────┘

```
---

## 📜 4. Terraform / Ansible 役割分担

| 項目 | Terraform | Ansible |
|---|:--:|:--:|
| VPC作成 | ✅ | ❌ |
| Subnet作成 | ✅ | ❌ |
| Firewall設定（80 / 22） | ✅ | ❌ |
| VM作成（Rocky Linux） | ✅ | ❌ |
| 外部IP付与 | ✅ | ❌ |
| SSHキー登録 | ✅ | ❌ |
| nginxインストール | ❌ | ✅ |
| nginx.conf編集 | ❌ | ✅ |
| index.html配置 | ❌ | ✅ |
| サービス起動・有効化 | ❌ | ✅ |
