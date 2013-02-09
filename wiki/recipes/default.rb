#
# Cookbook Name:: wiki
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# fswiki インストールの事前準備
%w{
perl-CGI unzip
}.each do |package_name|
	package package_name do
		action :install
	end
end


# Source の Download と展開
cookbook_file "/tmp/wiki3_6_4.zip" do
       source "wiki3_6_4.zip"
       mode "0644"
end

script "unzip" do
       interpreter "bash"
       user "root"
       cwd "/tmp"
       code <<-EOH
               unzip wiki3_6_4.zip
       EOH
end
