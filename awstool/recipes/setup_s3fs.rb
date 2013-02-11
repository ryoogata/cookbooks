# Source の Download
%w{
	fuse fuse-libs fuse-devel
}.each do |package_name|
	cookbook_file "/tmp/#{package_name}-2.8.6-1.10.amzn1.x86_64.rpm" do
		source "#{package_name}-2.8.6-1.10.amzn1.x86_64.rpm"
		mode "0644"
	end
end


# fuse のインストール
%w{
	fuse fuse-libs fuse-devel
}.each do |package_name|
	package "#{package_name}" do
		action :install
		source "/tmp/#{package_name}-2.8.6-1.10.amzn1.x86_64.rpm"
		provider Chef::Provider::Package::Rpm
	end
end


# 事前に必要なパッケージをインストール
%w{
	gcc-c++ make 
	curl-devel libxml2-devel openssl-devel
	git
}.each do |package_name|
        package package_name do
                action :install
        end
end


#s3fs の Download
git "/tmp/s3fs-cloudpack" do
  repository "git://github.com/memorycraft/s3fs-cloudpack.git "
  reference "master"
  action :sync
end


# s3fs のコンパイルとインストール
script "build s3fs" do
	interpreter "bash"
	user "root"
	cwd "/tmp/s3fs-cloudpack"
	code <<-EOH
		sh ./configure ; make ; make install
	EOH
end


# passwd-s3fs の設定と設置
template "/etc/passwd-s3fs" do
        source "passwd-s3fs.erb"
        owner "root"
        group "root"
        mode 0600
        variables(
                :accesskey => node["s3"]["_ACCESS_KEY"],
                :secretkey => node["s3"]["_SECRET_KEY"]
        )
end


# 不要なファイルの削除
%w{
        fuse fuse-libs fuse-devel
}.each do |package_name|
	file "/tmp/#{package_name}-2.8.6-1.10.amzn1.x86_64.rpm" do
		action :delete
	end
end


# 不要な Directory の削除
directory "/tmp/s3fs-cloudpack" do
        recursive true
        action :delete
end
