Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/xenial64"

    config.vm.synced_folder "data/mysql", "/var/lib/mysql", create: true
    config.vm.synced_folder "data/www", "/var/www", create: true

    config.vm.provision "shell", path: "setup_lemp.sh"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 2
    end

end
