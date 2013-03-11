# パスワードなしで sudo が実行できるように設定
script "setup_backup.conf" do
interpreter "bash"
	code <<-EOH
		sed -i "s/# %wheel/ %wheel/" /etc/sudoers
	EOH
end


# unzip のインストール
package "unzip" do
	action :install
end


# Source ファイルの設置
cookbook_file "/tmp/jdk-6u39-linux-x64-rpm.bin" do
        source "jdk-6u39-linux-x64-rpm.bin"
        mode "0755"
end


# JDK のインストール
execute "jdk-6u39-linux-x64-rpm.bin" do
	command 'echo | /tmp/jdk-6u39-linux-x64-rpm.bin'
end


# Java コマンドの切り替え
execute "alternatives" do
	command 'alternatives --install /usr/bin/java java /usr/java/jdk1.6.0_39/bin/java 20000'
end


# Host 共通の環境変数を設定
cookbook_file "/etc/profile.d/java.sh" do
        source "java.sh"
        mode "0755"
end


execute "java.sh" do
        command 'bash /etc/profile.d/java.sh'
end


# CDH3 の Repository の取得
remote_file "/tmp/cdh3-repository-1.0-1.noarch.rpm" do
	source "http://archive.cloudera.com/redhat/6/x86_64/cdh/cdh3-repository-1.0-1.noarch.rpm"
end


# CDH3 の Repository のインストール
package "cdh3-repository" do
	action :install
	source "/tmp/cdh3-repository-1.0-1.noarch.rpm"
	provider Chef::Provider::Package::Rpm
end


# Hadoop 本体のインストール
package "hadoop-0.20" do
	action :install
end


# 作業 Directory の作成
%w{
	hadoop hadoop/input
}.each do |directory_name|
	directory "/tmp/#{directory_name}" do
		action :create
		recursive true
	end
end


# サンプルデータの取得 ( 吾輩は猫である )
cookbook_file "/tmp/wagahaiwa_nekodearu.txt.zip" do
        source "wagahaiwa_nekodearu.txt.zip"
end


# サンプルデータの展開
script "unzip" do
       interpreter "bash"
       user "root"
       cwd "/tmp"
       code <<-EOH
               unzip wagahaiwa_nekodearu.txt.zip
       EOH
end


# 疑似分散モード利用の為のパッケージのインストール
package "hadoop-0.20-conf-pseudo" do
	action :install
end


# ネームノードを起動する
service "hadoop-0.20-namenode" do
	action :start
end


# データノードを起動する
service "hadoop-0.20-datanode" do
	action :start
end


# セカンダリネームノードを起動する
service "hadoop-0.20-secondarynamenode" do
	action :start
end


# タスクトラッカーを起動する
service "hadoop-0.20-tasktracker" do
	action :start
end


# ジョブトラッカーを起動する
service "hadoop-0.20-jobtracker" do
	action :start
end
