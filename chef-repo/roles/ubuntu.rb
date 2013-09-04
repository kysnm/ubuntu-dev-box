name "rails-development"
description "setup for ruby on rails core development"
run_list(
  "recipe[apt]",
  "recipe[preinstall]",
  "recipe[git]",
  "recipe[sqlite]",
  "recipe[mysql::client]",
  "recipe[mysql::ruby]",
  "recipe[mysql::server]",
  "recipe[plenv]",
  "recipe[plenv::install]",
  "recipe[plenv::global]",
  "recipe[plenv::cpanm]",
  "recipe[nodebrew]",
  "recipe[ruby_build]",
  "recipe[rbenv::user]",
  "recipe[rbenv::vagrant]",
  "recipe[postinstall]"
)
