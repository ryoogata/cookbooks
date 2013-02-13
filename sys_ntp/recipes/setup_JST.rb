# ローカルタイムを JST に設定
file "/etc/localtime" do
  content IO.read("/usr/share/zoneinfo/Japan")
end
