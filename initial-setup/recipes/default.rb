#
# Cookbook Name:: initial-setup
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "setuptool" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "setuptool" }
  )
end

package "system-config-network-tui" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "system-config-network-tui" }
  )
end

package "system-config-firewall-tui" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "system-config-firewall-tui" }
  )
end

package "ntsysv" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "ntsysv" }
  )
end

package "man" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "man" }
  )
end

package "wget" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "wget" }
  )
end

package "file" do
  package_name value_for_platform(
    [ "centos" ] => { "default" => "file" }
  )
end
