HOME=/home/pi
PRINTERUI_URL=git@github.com:/Voxel8/printer_ui
AUTOMATION_SCRIPTS_URL=git@github.com:Voxel8/printer-automation.git
FIRMWARE_URL=git@github.com:Voxel8/Marlin.git

sudo apt-get -y install arduino x11-xserver-utils --fix-missing

# Generate SSH keys and add to agent
mkdir $HOME/.ssh
chmod 700 $HOME/.ssh
yes | ssh-keygen -b 4096 -t rsa -f $HOME/.ssh/id_rsa -q -N ""
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa

# Push ssh key to github
KEY=`cat $HOME/.ssh/id_rsa.pub`
curl -u Voxel8RaspiBot:voxel8isgr8m8 --data "{\"title\": \"frompi\", \"key\": \"$KEY\"}" https://api.github.com/user/keys

# add Github to known_hosts
ssh-keyscan -H github.com >> /home/pi/.ssh/known_hosts

# Install printer_ui
cd
git clone $PRINTERUI_URL
cd $HOME/printer_ui
chmod +x install.sh
./install.sh

# Install automation scripts
cd $HOME
git clone $AUTOMATION_SCRIPTS_URL
ln -s $HOME/printer-automation $HOME/.mecodescripts

# Grab firmware
cd $HOME
git clone $FIRMWARE_URL

