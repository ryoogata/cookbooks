%w{
	hadoop-hbase hadoop-hbase-master hadoop-hbase-regionserver hadoop-zookeeper-server
}.each do |package|
	package "#{package}" do
		action :install
	end
end


# 疑似分散モードでの設定ファイルを設置
cookbook_file "/etc/hbase/conf/hbase-site.xml" do
        source "hbase-site.xml"
	mode 0644
end


# zookeeper の設定ファイルを設置
cookbook_file "/etc/zookeeper/zoo.cfg" do
	source "zoo.cfg"
	group "zookeeper"
	mode 0655
end


# hdfs-site.xml の設定と設置
template "/etc/hadoop/conf/hdfs-site.xml" do
	source "hdfs-site.xml"
	mode 0644
end

# hdfs-site.xml の設定後の datanode の再起動
service "hadoop-0.20-datanode" do
        action :restart
end

service "hadoop-zookeeper-server" do
        action :start
end

service "hadoop-hbase-master" do
        action :start
end

service "hadoop-hbase-regionserver" do
        action :start
end
