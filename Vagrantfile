# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don"t touch unless you know what you"re doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the "config.vm.box" box will be fetched if it
  # doesn"t already exist on the user"s system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don"t boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you"re using for more
  # information on available options.

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  config.omnibus.chef_version = :latest
  config.librarian_chef.cheffile_dir = "chef-repo"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef-repo/cookbooks", "chef-repo/site-cookbooks"]
    chef.roles_path = "chef-repo/roles"
    chef.data_bags_path = "chef-repo/data_bags"

    chef.add_role "ubuntu"

   # You may also specify custom JSON attributes:
    chef.json = {
      :mysql => {
        :server_root_password   => "",
        :server_debian_password => "",
        :server_repl_password   => ""
      },
      "ruby_build" => {
        "upgrade" => "sync"
      },
      :plenv => {
        :users => [
          {
            :name => "vagrant",
            :gname => "vagrant",
            :versions => [
              {
                :version => "5.8.9",
              },
              {
                :version => "5.12.5",
                :cpanm_options => "--force",
                :modules => %w[
                  App::Ack
                ],
              },
              {
                :version => "5.14.4",
                :cpanm_options => "--force",
                :modules => %w[
                  App::Ack
                ],
              },
              {
                :version => "5.18.1",
                :cpanm_options => "--force",
                :modules => %w[
                  App::Ack
                ],
              },
            ],
            :global => "5.12.5",
          },
        ],
      },
      :nodebrew => {
        :user => "vagrant",
        :root => "/home/vagrant/.nodebrew",
        :nodes => [
          { :version => "0.11.6" },
          { :version => "0.10.17" }
        ],
        :use => "0.10.17",
        :npm => {
          "0.11.6" => [
            "yo"
          ],
          "0.10.17" => [
            "yo"
          ]
        }
      },
      "rbenv" => {
        "user_installs" => [
          "user" => "vagrant",
          "root_path" => "/home/vagrant/.rbenv",
          "global"  => "1.9.3-p448",
          "rubies" => [ "1.8.7-p374", "1.9.3-p448", "2.0.0-p247"],
          "gems" => {
            "1.8.7-p374" => [
              { "name" => "bundler" }
            ],
            "1.9.3-p448" => [
              { "name" => "bundler" }
            ],
            "2.0.0-p247" => [
              { "name" => "bundler" }
            ],
          }
        ]
      }
    }

  end
end
