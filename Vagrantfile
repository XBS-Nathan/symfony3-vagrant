Vagrant.configure("2") do |config|
    # Configure the box to use
    config.vm.box       = 'precise64'
    config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
    config.vm.hostname = 'dev.batterystation.co.uk'

    # Configure shared folders
    config.vm.synced_folder ".",  "/vagrant", id: "vagrant-root", :nfs => true
    config.vm.synced_folder "..", "/var/www", id: "application",  :nfs => true

    #Manager the host file
    config.hostmanager.enabled = true

    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.vm.define 'dev.batterystation.co.uk' do |node|
        node.vm.network :private_network, ip: '192.168.42.42'
        node.hostmanager.aliases = %w(dev.batterystation.co.uk)
    end


    # Configure VirtualBox environment
    config.vm.provider :virtualbox do |v|
        v.name = (0...8).map { (65 + rand(26)).chr }.join
        v.customize [ "modifyvm", :id, "--memory", 512 ]
    end

    # Provision the box
    config.vm.provision :ansible do |ansible|
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
        ansible.playbook = "ansible/site.yml"
    end
end
