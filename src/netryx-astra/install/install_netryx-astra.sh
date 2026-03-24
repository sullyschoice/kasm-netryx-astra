#!/usr/bin/env bash
set -ex

apt-get update
apt-get install -y python3-venv python3-tk
cd /opt
git clone https://github.com/sparkyniner/Netryx-Astra-V2-Geolocation-Tool.git
cd Netryx-Astra-V2-Geolocation-Tool
chmod +x setup.sh
./setup.sh

cat >/opt/Netryx-Astra-V2-Geolocation-Tool/launch.sh <<EOL
#!/bin/bash
export LD_LIBRARY_PATH=/opt/Netryx-Astra-V2-Geolocation-Tool/venv/lib/python3.12/site-packages/nvidia/cudnn/lib/:\$LD_LIBRARY_PATH
cd /opt/Netryx-Astra-V2-Geolocation-Tool/
source venv/bin/activate
python3 test_super.py
EOL


chmod +x /opt/Netryx-Astra-V2-Geolocation-Tool/launch.sh
chown -R 1000:1000 /opt/Netryx-Astra-V2-Geolocation-Tool/
chown -R 1000:1000 /opt/mast3r/


cat >/usr/share/applications/netryx-astra.desktop <<EOL
[Desktop Entry]
Version=1.0
Name=Netryx Astra
Comment=State-of-the-art AI geolocation from a single image.
TryExec=/opt/Netryx-Astra-V2-Geolocation-Tool/launch.sh
Exec=/opt/Netryx-Astra-V2-Geolocation-Tool/launch.sh -- %u
Icon=/opt/Netryx-Astra-V2-Geolocation-Tool/netryx-astra.png
Terminal=true
StartupWMClass=Netryx Astra
Type=Application
Categories=Multimedia;
EOL

chmod +x /usr/share/applications/netryx-astra.desktop
chown 1000:1000 /usr/share/applications/netryx-astra.desktop
cp /usr/share/applications/netryx-astra.desktop $HOME/Desktop/netryx-astra.desktop

cd /tmp
wget https://raw.githubusercontent.com/kasmtech/workspaces-images/refs/heads/develop/src/ubuntu/install/chrome/install_chrome.sh
bash ./install_chrome.sh
rm ./install_chrome.sh