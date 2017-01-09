require 'yaml'

Vagrant.configure("2") do |config|

    user_config = YAML.load_file 'user_config.yml'
    
    
    config.vm.box = "bento/ubuntu-16.04"

    config.vm.network "private_network", ip: "192.168.10.10"
    
    config.vm.hostname = "dev-container"

    config.vm.synced_folder "data/mysql", "/var/lib/mysql", create: true
    config.vm.synced_folder "data/www", "/var/www", create: true

    config.vm.provision "shell", inline: 'cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys'
    config.vm.provision "shell", path: "setup_system.sh"
    config.vm.provision "shell", path: "setup_projects.sh"
    config.vm.provision "shell", inline: 'su - it -c "git config --global url.ssh://git@github.com/.insteadOf https://github.com/"'
    config.vm.provision "shell", inline: 'su - it -c "git config --global user.name ' + user_config['git']['username'] + '"'
    config.vm.provision "shell", inline: 'su - it -c "git config --global user.email ' + user_config['git']['email'] + '"'
    config.vm.provision "shell", inline: '
        mkdir -p /home/it/.composer
        echo {\"github-oauth\": {\"github.com\": \"'+user_config['git']['composer_access_token']+'\"}} > /home/it/.composer/auth.json
        chown -R it:it /home/it/.composer
    '

    config.ssh.username = "vagrant"
    config.ssh.port = 22
    config.ssh.private_key_path = ["./initial_ssh_key", user_config['ssh_private_key_path']]
    config.ssh.forward_agent = true


    # config.vm.network "public_network"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 2
    end

end
