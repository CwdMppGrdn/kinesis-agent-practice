# kinesis-agent-practice

## TLDR
- Kinesis Agentの動作確認用のTerraformコード
- 簡単のためEC2 Instance ConnectでEC2にアクセスする
- Kineisis Agentのconfig設定はSSMパラメータストアで管理し、userdataでEC2構築時にセットアップする