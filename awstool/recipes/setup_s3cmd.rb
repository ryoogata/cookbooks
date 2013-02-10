# python-magic のインストール
%w{
	python-magic unzip wget
}.each do |package_name|
        package package_name do
                action :install
        end
end


# Source の Download
cookbook_file "/tmp/s3cmd-1.1.0-beta3.zip" do
       source "s3cmd-1.1.0-beta3.zip"
       mode "0644"
end


# Source の展開
script "unzip" do
       interpreter "bash"
       user "root"
       cwd "/tmp"
       code <<-EOH
               unzip s3cmd-1.1.0-beta3.zip
       EOH
end


# s3cmd のコンパイルとインストール
script "build s3cmd" do
       interpreter "bash"
       user "root"
       cwd "/tmp/s3cmd-1.1.0-beta3"
       code <<-EOH
               python setup.py install
       EOH
end


# .s3cfg の設定と設置
template "/root/.s3cfg" do
	source "s3cfg.erb"
	owner "root"
	group "root"
	mode 0600
        variables(
                :accesskey => node["s3"]["_ACCESS_KEY"],
                :secretkey => node["s3"]["_SECRET_KEY"]
        )
end


# 不要なファイルの削除
file "/tmp/s3cmd-1.1.0-beta3.zip" do
	action :delete
end


# 不要な Directory の削除
directory "/tmp/s3cmd-1.1.0-beta3" do
	recursive true
	action :delete
end
