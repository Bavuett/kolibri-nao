#Programmer: Ciarrocchi Christian
#Created: 27/05/2022
#Default Yun IP: 192.168.1.255, default port: 7891

import socket #nao is a client
import time

class MyClass(GeneratedClass):
    command = ""

    def __init__(self):
        GeneratedClass.__init__(self, False)
        self.tts = ALProxy('ALTextToSpeech')
        self.ttsStop = ALProxy('ALTextToSpeech', True)

    def onLoad(self):
        self.bIsRunning = False
        self.ids = []
        active = True
        # For tcp
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # To fix the address already in use issue
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        # Bind to all the interfaces on port 8080
        sock.bind(("0.0.0.0", 8080))
        # Number of backlog clients
        sock.listen(2)
        self.log("Waiting for client....!")
        while active == True:
            (client, (ip, port)) = sock.accept()
            self.log('client connected with ip as {} and port {}'.format(ip, port))
            data = client.recv(2048)

            while len(data):
                self.log("Client sent the data : {}".format(data))
                client.send(data.upper())

                received = data.decode("utf8")
                id = self.tts.pCall("say",str(received))
                self.ids.append(id)

                if received == "":
                    self.log(received)
                elif received == "close":
                    active = False
                    self.log("Closing the Socket.")
                
                data = client.recv(2048)
            self.log("Client closed connection !!! :( ")
            client.close()


        self.log("Closing the Socket!!")
        sock.close()
        #put initialization code here
        pass

    def onUnload(self):
        for id in self.ids:
            try:
                self.ttsStop.stop(id)
            except:
                pass
        while( self.bIsRunning ):
            time.sleep( 0.2 )
        #put clean-up code here
        pass

    def onInput_onStart(self):
        #self.onStopped() #activate the output of the box
        #self.processing()
        pass

    def onInput_onStop(self):
        self.log("Closing the Socket!!")
        self.onUnload() #it is recommended to reuse the clean-up as the box is stopped
        self.onStopped() #activate the output of the box

    def processing(self):
        pass
