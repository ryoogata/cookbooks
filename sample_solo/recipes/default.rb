#
# Cookbook Name:: sample_solo
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template '/tmp/chef_solo-test' do
  source 'chef_solo-test.erb'
  mode 0644
end

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
