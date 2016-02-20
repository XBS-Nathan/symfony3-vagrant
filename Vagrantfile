require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/ansible/site.yml")
vagrant_config = configs['vars']

Vagrant.configure("2") do |config|
    # Configure the box to use
    config.vm.box       = 'precise64'
    config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
    config.vm.hostname  = vagrant_config['server_name']

    # Configure shared folders
    config.vm.synced_folder ".",  "/vagrant", id: "vagrant-root", :nfs => true
    config.vm.synced_folder "..", "/var/www", id: "application",  :nfs => true

    #Manager the host file
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    

    config.vm.define vagrant_config['server_name'] do |node|
        node.vm.network :private_network, ip: vagrant_config['ip_address']
        node.hostmanager.aliases = %w(vagrant_config['server_name'])
    end


    # Configure VirtualBox environment
    config.vm.provider :virtualbox do |v|
        v.name = (0...8).map { (65 + rand(26)).chr }.join
        v.customize [ "modifyvm", :id, "--memory", 4096 ]
        v.customize ["modifyvm", :id, "--cpus", "4"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
    end

    # Provision the box
    config.vm.provision :ansible do |ansible|
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
        ansible.verbose = "vvv"
        ansible.playbook = "ansible/site.yml"
    end
end
