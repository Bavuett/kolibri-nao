#Programmer: Ciarrocchi Christian
#Created: 27/05/2022
#Default Yun IP: 192.168.1.*, default port: 7891
#NAO Tp-link IP: 192.168.1.110

import socket #nao is a server
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
        id = self.tts.post.say(str("Pronto per connettermi all'app!"))
        self.ids.append(id)
        while active == True:
            (client, (ip, port)) = sock.accept()
            self.log('client connected with ip as {} and port {}'.format(ip, port))
            data = client.recv(2048)

            while len(data):
                self.log("Client sent the data : {}".format(data))
                client.send(data.upper())

                received = data.decode("utf8")
                
                interview = "Scusa, non ho capito"

                if received == "":
                    self.log(received)
                    interview = "Scusa, non ho capito"
                elif received == "close":
                    active = False
                    self.log("Closing the Socket.")
                    id = self.tts.pCall("say", "Chiuderò la connessione non appena l'app si disconnetterà.")
                    self.ids.append(id)
                    interview = ""

                elif received == "quando sei nato":
                    interview = "Nacqui nel 1891 a Popoli, comune allora della provincia dell'Aquila, oggi di Pescara in Abruzzo, da Giacomo e Anna De Michele; il palazzo della mia famiglia si trova sul corso Gramsci, al tempo corso Vittorio Emanuele, all'angolo con via Venezia."

                elif received == "dove hai studiato":
                    interview = "Frequentai il Regio Istituto Tecnico Ferdinando Galiani di Chieti, diplomandomi nel 1909 e volendo intraprendere studi ingegneristici, mi trasferì a Torino iscrivendomi al Regio Istituto Superiore d'Ingegneria che all'epoca rappresentava il massimo nel campo dell'ingegneria meccanica. Mi laureai nel 1914 in ingegneria industriale meccanica al Politecnico di Torino."

                elif received == "che esperienze hai":
                    interview = "Nel gennaio 1918 mi trasferì a Indianapolis negli Stati Uniti, al servizio della neonata Pomilio Brothers Corporation, costruendo due apparecchi. Ben presto i rapporti con la società s'incrinarono ma non mi scoraggiai e percorsi altre strade nel campo dell'industria aeronautica statunitense e costruì una società aeronautica con l'ingeniere Ugo Veniero D'Annunzio, figlio di Gabriele D'Annunzio e allora progettista presso la Caproni Airlines di Detroit, per la realizzazione di un aeroplano equipaggiato con un motore di motocicletta Harley Davidson. La mia avventura in America non ebbe tuttavia i risultati sperat    i e nel settembre 1919 feci ritorno in Italia."

                elif received == "elicottero":
                    interview = " Continuai sempre gli studi ed esperimenti legati al mondo del volo, e nel biennio 1923 24 è documentata una spesa di 266 mila 510 lire per lo studio di un ortottero. Poco dopo fondai una Società con il barone Pietro Troiani di Pescosansonesco, che credette subito nel progetto dellelicottero e mise a disposizione il suo patrimonio, con lo scopo di far sorgere e prosperare unindustria aviatoria in questa industriosa zona dAbruzzo. Dallo studio incessante sul volo verticale nacque il brevetto dellelicottero a due eliche coassiali. Tra il 1925 e il 1930 sono numerosi i brevetti della nuova società relativi al mondo aeronautico e non solo. Venne avviata la costruzione e lassemblaggio dei pezzi meccanici che compongono lelicottero.In base ad un accordo con Eugenio Camplone, i pezzi sono prodotti presso le omonime officine di Pescara. In cambio, avevo il compito di progettare per le Officine Camplone macchine industriali e agricole. Nascono nel cortile delle officine Camplone a Pescara i prototipi dellelicottero DAT1 e DAT2. Entrambi volano per pochi secondi e poi ricadono a terra. I prototipi consentirono in seguito di progettare un nuovo elicottero, molto superiore ai precedenti il DAT3 commissionato dal Ministero dellAeronautica per un importo di 600.000 lire, fu realizzato nelle officine del Genio Aeronautico a Roma. Le prove di volo vengono effettuate nellaeroporto militare di Ciampino Nord. Nellottobre del 1930 il DAT3, con un motore Fiat A.50 S HP90 conquista i primati internazionali di: durata del volo con ritorno senza scalo 8primi4secondi distanza in linea retta senza scalo 1078metri,60metri altezza sul punto di partenza 18metri. "


                id = self.tts.post.say(str(interview))
                self.ids.append(id)
                client.recv(2048)
            self.log("Closing the Socket.")
            id = self.tts.pCall("say", "L'app si è disconnessa.")
            self.log("Client closed connection !!! :( ")
            client.close()

        id = self.tts.pCall("say", "Ho chiuso il server. Termina e riavvia il programma per ricominciare l'intervista.")
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
