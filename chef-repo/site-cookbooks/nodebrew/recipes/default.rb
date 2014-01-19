#
# Cookbook Name:: nodebrew
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

username  = 'vagrant'
groupname = 'vagrant'
homedir   = '/home/vagrant'

execute "setup-nodebrew" do
  user  "#{username}"
  group "#{groupname}"
  environment ({'HOME' => homedir, 'USER' => username})
  command <<-EOH
    curl -L git.io/nodebrew | perl - setup
  EOH
  Chef::Log::debug "#{homedir}/.nodebrew exsists? ".concat(File.exist?("#{homedir}/.nodebrew").to_s)
  notifies :run, "execute[setenv-for-nodebrew]"
  notifies :run, "execute[install-node]"
  not_if { File.exist?("#{homedir}/.nodebrew") }
end

execute "setenv-for-nodebrew" do
  user  "#{username}"
  group "#{groupname}"
  environment ({'HOME' => homedir, 'USER' => username})
  command <<-EOH
    echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> #{homedir}/.bashrc
  EOH
  action :nothing
end

execute "install-node" do
  user  "#{username}"
  group "#{groupname}"
  environment ({'HOME' => homedir, 'USER' => username})
  command <<-EOH
    #{homedir}/.nodebrew/current/bin/nodebrew install-binary latest
    #{homedir}/.nodebrew/current/bin/nodebrew install-binary stable
    #{homedir}/.nodebrew/current/bin/nodebrew alias default stable
    #{homedir}/.nodebrew/current/bin/nodebrew use latest
    #{homedir}/.nodebrew/current/bin/npm install -g yo koa co thunkify
    #{homedir}/.nodebrew/current/bin/nodebrew use stable
    #{homedir}/.nodebrew/current/bin/npm install -g yo express socket.io
    #{homedir}/.nodebrew/current/bin/nodebrew use default
  EOH
  action :nothing
end
