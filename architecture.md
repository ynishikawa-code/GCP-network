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

⚙️ 2. 使用技術スタック・リソース
項目	内容
OS	Rocky Linux 9（GCP Marketplace）
VPC	Terraformで作成（例：web-vpc）
Subnet	Terraformで作成（10.0.1.0/24）
Firewall	Terraformで HTTP(80), SSH(22) を許可
VM	Terraformで1台作成（外部IP付き）
Ansible	nginx インストール・起動・設定
SSH接続	Terraformで鍵登録 or 公開鍵指定
GitHub管理	Terraform / Ansible コード管理
GitHub Actions	plan/apply・ansible自動化（任意）
🪄 3. ディレクトリ構成
gcp-network/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
├── ansible/
│   ├── inventory
│   ├── playbook.yml
│   └── roles/
│       └── nginx/
│           ├── tasks/main.yml
│           └── templates/
├── diagrams/
│   └── network-architecture.drawio
├── README.md
└── .gitignore

📜 4. Terraform / Ansible 役割分担
項目	Terraform	Ansible
VPC作成	✅	❌
Subnet作成	✅	❌
Firewall設定	✅	❌
VM作成	✅	❌
外部IP付与	✅	❌
SSHキー登録	✅	❌
nginxインストール	❌	✅
nginx.conf編集	❌	✅
index.html配置	❌	✅
サービス起動・有効化	❌	✅
🪧 5. 設定例
Terraform 変数定義（例）
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  default = "asia-northeast1"
}

variable "zone" {
  default = "asia-northeast1-a"
}

variable "instance_name" {
  default = "web-server"
}

Ansible Inventory（例）
[web]
<EXTERNAL_IP> ansible_user=rocky ansible_ssh_private_key_file=~/.ssh/your_key.pem

📝 補足