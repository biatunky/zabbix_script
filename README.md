#check_expiry_date_of_reserved_instance.rb
##概要  
AWS/ec2のリザーブドインスタンスの有効期限をzabbixで監視する為のスクリプトです。  
このスクリプトをどうさせる為には、ec2にタグ付けした上で、zabbixサーバ側の設定も必要になります。  
また、リザーブドインスタンスは特定のec2インスタンスに紐づいている運用を想定しています。
##設定方法
1. ec2インスタンスのNameタグにzabbixに登録したホスト名を記載する。
2. ec2インスタンスにReservedIdタグを追加して、このインスタンスに紐づけるリザーブドインスタンスIDを記載する。
3. zabbixサーバのExternalScriptsにこのスクリプトを設置する。
4. zabbixサーバの外部チェックで  check_expiry_date_of_reserved_instance.rb[{HOSTNAME}]    
を設定する。
5. リザーブドインスタンスの残り日数が監視できる。
