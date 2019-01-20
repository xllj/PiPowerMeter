#!/bin/sh

# update OS
echo '>>> Update OS Image'
sudo apt-get update
sudo apt-get -y upgrade

# install nodejs via nvm
echo '>>> Install NodeJs'
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
sudo cp -R $NVM_DIR/versions/node/$(nvm version)/* /usr/local/

# install git
echo '>>> Install Git'
sudo apt-get -y install git

# install and configure PiPowerMeter
echo '>>> Install PiPowerMeter'
git clone https://github.com/crjens/PiPowerMeter.git app
cd app
git checkout test
git pull
npm install
 
# expand filesystem
echo '>>> Expand FileSystem'
sudo raspi-config nonint do_expand_rootfs

echo '>>> PiPowerMeter is installed, restarting...'
sudo reboot