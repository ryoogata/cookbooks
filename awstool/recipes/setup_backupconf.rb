# backup.conf の設定と設置
template "/root/backup.conf" do
        source "backup.conf.erb"
        owner "root"
        group "root"
        mode 0600
end

#FIX-ME: sed がうまく動かない
# backup.conf のスペースを削除し、"," を改行に変換する
script "sed" do
       interpreter "bash"
       user "root"
       cwd "/root"
       code <<-EOH
		/bin/sed -i "s/,/\n/g" /root/backup.conf
       EOH
end
