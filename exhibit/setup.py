# configures a Rasberry Pi to run start.py script on boot

import os

# install dub and put it in the path
os.system("""
wget https://github.com/ldc-developers/ldc/releases/download/v1.7.0/ldc2-1.7.0-linux-armhf.tar.xz
tar xf ldc2-1.7.0-linux-armhf.tar.xz
sudo mv ldc2-1.7.0-linux-armhf /opt/
sudo apt-get install libevent-dev libssl-dev
sudo apt-get install gcc
export PATH="/opt/ldc2-1.7.0-linux-armhf/bin:$PATH"
""")

# install painless mesh listener
os.system("""
git clone https://BlackEdder@gitlab.com/BlackEdder/painlessMeshListener.git
cd painlessMeshListener
dub
""")