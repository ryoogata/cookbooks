package "hadoop-hive" do
        action :install
end


user "hiveuser" do
	action :create
end


directory "/var/lib/hive/metastore" do
	mode 00757
end


execute "usermod" do
	command "usermod -G wheel hiveuser"
end


script "make_home_dir" do
	interpreter "bash"
        user "hdfs"
	code <<-EOH
		hadoop fs -mkdir /user/hiveuser
		hadoop fs -chown hiveuser /user/hiveuser
	EOH
end


script "make_hive_dir" do
	interpreter "bash"
        user "hdfs"
	code <<-EOH
		hadoop fs -mkdir /user/hive/warehouse
		hadoop fs -chown -R hiveuser /user/hive
	EOH
end


script "make_tmp_dir" do
	interpreter "bash"
        user "hdfs"
	code <<-EOH
		hadoop fs -mkdir /tmp
		hadoop fs -chown hiveuser /tmp
	EOH
end


script "change_owner" do
	interpreter "bash"
        user "hiveuser"
	code <<-EOH
		hadoop fs -chmod a+w /tmp
		hadoop fs -chmod a+w /user/hive/warehouse
	EOH
end
