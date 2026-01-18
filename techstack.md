# 技術スタック（IaC 学習環境）

本リポジトリでは、Red Hat 系 Linux 環境およびクラウドインフラ構築・運用の実務的な理解を目的として、  
Google Cloud Platform 上に Infrastructure as Code（IaC）を用いた検証環境を構築する。

---

## 技術スタック一覧

| 分類 | ツール / サービス | 用途 | 補足 |
|---|---|---|---|
| OS | Rocky Linux 9 | サーバー OS | Red Hat Enterprise Linux 互換。GCP Compute Engine 上で使用 |
| クラウド | Google Cloud Platform (GCP) | インフラ基盤 | VPC、Compute Engine、Firewall、IAM などを管理 |
| IaC | Terraform | インフラ構築・管理 | Terraform v1.5 以上、google provider を使用 |
| 構成管理 | Ansible | OS・ミドルウェア設定管理 | Terraform と責務分離し、SSH 経由で構成を自動化 |
| バージョン管理 | Git / GitHub | ソースコード管理 | Terraform / Ansible のコードを一元管理 |
| CI/CD | GitHub Actions | 自動化パイプライン | Pull Request 時に Plan、Merge 時に Apply を実行 |
| エディタ | Visual Studio Code | 開発環境 | Terraform / Ansible / YAML / SSH 拡張を使用 |
| 設計補助 | draw.io / Lucidchart | インフラ構成図作成 | ネットワークおよびリソース構成の可視化 |
| 認証 | GCP サービスアカウント | GCP API 操作 | Terraform / Ansible から利用 |
| 秘密管理 | .env / GitHub Secrets | 認証情報管理 | 機密情報はリポジトリに含めず安全に管理 |

---

## 設計方針

- **Terraform と Ansible の責務分離**
  - Terraform：クラウドリソース（VPC、VM、Firewall 等）の定義と管理
  - Ansible：OS 内部の設定、パッケージ管理、ミドルウェア設定

- **再現性・自動化を重視**
  - GitHub Actions により、手動操作を最小限に抑えた構成管理を実現

- **実務を想定した構成**
  - Red Hat 系 Linux、GCP、IaC を組み合わせ、企業環境に近い構成を意識

---

## セキュリティ方針

- GCP サービスアカウントキーは `.json` ファイルとして管理し、  
  ローカル環境および CI/CD では環境変数または GitHub Secrets を利用
- 機密情報は Git 管理対象外とする

---

