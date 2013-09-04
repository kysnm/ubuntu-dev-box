#
# Cookbook Name:: postinstall
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "chown" do
  cwd "/home/vagrant/"
  code <<-EOH
    chown -R vagrant:vagrant .nodebrew
  EOH
end
