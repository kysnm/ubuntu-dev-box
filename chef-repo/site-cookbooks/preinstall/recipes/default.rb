#
# Cookbook Name:: preinstall
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default[:packages].each do |p|
  package p do
    action :install
  end
end
