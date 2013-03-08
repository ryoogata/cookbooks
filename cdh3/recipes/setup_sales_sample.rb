# サンプルデータ用 Directory の作成
directory "/home/hiveuser/hive/sales_sample" do
	owner "hiveuser"
	group "hiveuser"
	action :create
	recursive true
end


# サンプル用ファイルの設置
%w{
	sales_detail.tsv shoplist.tsv itemlist.tsv sales.tsv
}.each do |file|
	cookbook_file "/home/hiveuser/hive/sales_sample/#{file}" do
		owner "hiveuser"
		group "hiveuser"
        	source "#{file}"
	end
end
