# backup.conf の設定と設置
template "/root/backup.conf" do
        source "backup.conf.erb"
        owner "root"
        group "root"
        mode 0600
end


# backup.conf のスペースを削除し、"," を改行に変換する
script "setup_backup.conf" do
	interpreter "bash"
	code <<-EOH
		sed -i "s/ //g" /root/backup.conf
		sed -i "s/,/\\n/g" /root/backup.conf
	EOH
end
