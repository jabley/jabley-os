Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true

  # By default, Vagrant will share your project directory (the
  # directory with the Vagrantfile) to /vagrant.

  config.vm.provider "virtualbox" do |vb|
     vb.cpus = "2"
     vb.memory = "4096"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
     sudo apt-get update
     sudo apt-get install -y nasm xorriso qemu
SHELL

end
