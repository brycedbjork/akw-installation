# starts the exhibit, rotating through pieces

import os
import time
import OSC
#os.system("painlessMeshBoost -c 10.20.201.2 >> logs.log")
#os.system("painlessMeshBoost -c 127.0.0.1 >> logs.log")

#ip='172.29.29.60'
ip='127.0.0.1'

c = OSC.OSCClient()
c.connect((ip, 12001))

class Listener():
	osc_client = None

	def add_osc_connect(self, client_connection):
		self.osc_client = client_connection
		print(self.osc_client)

	def sendOSC(self, content):
		msg = OSC.OSCMessage()
		msg.setAddress("/test")
		for c in content:
			msg.append(c)
		self.osc_client.send(msg)

listener = Listener()
listener.add_osc_connect(c)
old_length = 0

#file = open('test.log', 'r')
file = open('sensor_record.txt', 'r')
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
        print(data)
    except Exception as e:
        print(e)
        print(data)
        exit(1)
    length = int(data[-10:])
    print((length - old_length) / 1000.0)
    time.sleep((length - old_length) / 1000.0)
    old_length = length

print("All Done!")
