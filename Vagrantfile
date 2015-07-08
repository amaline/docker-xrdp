# -*- mode: ruby -*-
# vi: set ft=ruby :


disk1 = File.realpath(".").to_s + "/disk1.vdi"

Vagrant.configure(2) do |config|

  config.vm.box_download_insecure = true
  config.vm.box = "centos/atomic-host"
  #config.vm.hostname = "vw1amaline2xrdp"

  config.vm.network "private_network", ip: "10.0.2.20"
  #config.vm.network "private_network", ip: "10.245.2.20"

  #config.vm.network "public_network"
   config.vm.network "forwarded_port", guest: 3389, host: 8389

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant", type: "rsync", disabled: true


  config.vm.provider "virtualbox" do |vb|

   vb.memory = "2048"
   vb.gui = true

   if ARGV[0] == "up" && ! File.exists?(disk1)
     puts "Creating 10GB disk #{disk1}."
     vb.customize [ 'createhd' , '--filename', disk1 , '--size', 10 * 1024 ]
     vb.customize [ 'storageattach' , :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk1 ]
   end

  end


  config.vm.provision "shell", path: "scripts/add_new_disk.sh"
  config.vm.provision "shell", path: "scripts/addcert.sh"

end
