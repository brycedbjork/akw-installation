# starts the exhibit, rotating through pieces

import os
import time
import OSC

os.system("./painlessMeshBoost -c 10.20.201.2 >> logs.log")

c = OSC.OSCClient()
c.connect(('127.0.0.1', 6666))

listener = Listener()
listener.add_osc_connect(c)

file = open('logs.log', 'r')
while True:
  where = file.tell()
  line = file.readline()
  if not line:
    time.sleep(1)
    file.seek(where)
  else:
    data = line
    
    try:
        listener.sendOSC(data)
    except Exception as e:
        print(e)
