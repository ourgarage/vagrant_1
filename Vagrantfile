# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

# Checks before starting the server up
 # If SSH keys are not available
  #if(File.exist?('keys/1111.txt'))
    #p 'file or directory exists'
  #else
    #p 'file or directory not found'
  #end
  #exit 1

  config.vm.box = "bento/ubuntu-16.04"

  # Provisions
  config.vm.provision :shell, path: "provisions/setup_system.sh"
  config.vm.provision :shell, path: "provisions/setup_project.sh"
  
  config.vm.provision "file", source: "/vagrant/keys/1111.txt", destination: "/var/www/1111.txt"
  
  config.ssh.forward_agent = true

  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", ip: "192.168.10.10"

  # config.vm.network "public_network"

  config.vm.synced_folder "data/www", "/var/www", create: true
  config.vm.synced_folder "data/nginx", "/etc/nginx/sites-enabled", create: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
  end

  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
end
