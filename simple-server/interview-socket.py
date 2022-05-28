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
        id = self.tts.pCall("say", str("Aspetto che l'app si connetta"))
        self.ids.append(id)
        self.log("Waiting for client....!")
        while active == True:
            (client, (ip, port)) = sock.accept()
            id = self.tts.pCall("say", str("App connessa"))
            self.ids.append(id)
            self.log('client connected with ip as {} and port {}'.format(ip, port))
            data = client.recv(2048)

            while len(data):
                self.log("Client sent the data : {}".format(data))
                client.send(data.upper())

                received = data.decode("utf8")

                if received == "":
                    self.log(received)
                elif received == "close":
                    id = self.tts.pCall("say", str("Chiuderò il server alla disconnessione dell'app"))
                    self.ids.append(id)
                    active = False
                    self.log("Closing the Socket.")
                elif received == "quando sei nato":
                    id = self.tts.pCall("say", str("Nacqui nel 1891 a Popoli, comune allora della provincia dell Aquila, oggi di Pescara in Abruzzo, da Giacomo e Anna De Michele; il palazzo della mia famiglia si trova sul corso Gramsci, al tempo corso Vittorio Emanuele, allangolo con via Venezia"))
                    self.ids.append(id)
                elif received == "dove hai studiato":
                    id = self.tts.pCall("say", str("Frequentai il Regio Istituto Tecnico Ferdinando Galiani di Chieti, diplomandomi nel 1909 e volendo intraprendere studi ingegneristici, mi trasferì a Torino iscrivendomi al Regio Istituto Superiore dIngegneria che allepoca rappresentava il massimo nel campo dellingegneria meccanica. Mi laureai nel 1914 in ingegneria industriale meccanica al Politecnico di Torino."))
                    self.ids.append(id)
                
                data = client.recv(2048)
            id = self.tts.pCall("say", str("App disconessa"))
            self.ids.append(id)
            self.log("Client closed connection !!! :( ")
            client.close()

        id = self.tts.pCall("say", str("Ho chiuso il server"))
        self.ids.append(id)
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
