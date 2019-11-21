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

if __name__ == "__main__":

    listener = Listener()
    listener.add_osc_connect(c)
    data = ""
    while True:
        cmd = input("CMD: ")
        if cmd[0] == '1':
            data = 'st_1_1'
        elif cmd[0] == '2':
            data = 'st_2_1'
        elif cmd[0] == '3':
            data = 'st_3_1'
        elif cmd[0] == '4':
            data = 'st_4_1'
        elif cmd[0] == '5':
            data = 'st_5_1'
        elif cmd[0] == '6':
            data = 'st_6_1'
        elif cmd[0] == 'a':
            data = 'el_1_1'
        elif cmd[0] == 'd':
            data = 'el_2_1'
        else:
            data = cmd.zfill(6)
        try:
            listener.sendOSC(data)
            print(data)
        except Exception as e:
            print(e)
            print(data)
            exit(1)