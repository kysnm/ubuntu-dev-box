#
# Cookbook Name:: plenv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

username        = 'vagrant'
groupname       = 'vagrant'
plenv_repo      = 'git://github.com/tokuhirom/plenv.git'
perl_build_repo = 'git://github.com/tokuhirom/Perl-Build.git'
version         = node['perl-build']['version']
homedir         = '/home/vagrant'

execute "git-clone-plenv" do
  user  "#{username}"
  group "#{groupname}"
  environment ({'HOME' => homedir, 'USER' => username})
  command <<-EOH
  git clone #{plenv_repo} #{homedir}/.plenv
  git clone #{perl_build_repo} #{homedir}/.plenv/plugins/perl-build/
  EOH
  notifies :run, "execute[setenv-for-plenv]"
  notifies :run, "execute[build-perl]"
  not_if { File.exist?("#{homedir}/.plenv") }
end

execute "setenv-for-plenv" do
  user  "#{username}"
  group "#{groupname}"
  environment ({'HOME' => homedir, 'USER' => username})
  command <<-EOH
    echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> #{homedir}/.bashrc
    echo 'eval "$(plenv init -)"' >> #{homedir}/.bashrc
  EOH
  action :nothing
end

execute "build-perl" do
  user  "#{username}"
  group "#{groupname}"
  environment ({'HOME' => homedir, 'USER' => username})
  command <<-EOH
    #{homedir}/.plenv/bin/plenv rehash
    #{homedir}/.plenv/bin/plenv install #{version}
    #{homedir}/.plenv/bin/plenv global #{version}
    #{homedir}/.plenv/bin/plenv rehash
    #{homedir}/.plenv/bin/plenv install-cpanm
    #{homedir}/.plenv/bin/plenv rehash
  EOH
  action :nothing
end
