#Programmer: Ciarrocchi Christian
#Created: 27/05/2022
#Default Yun IP: 192.168.1.255, default port: 7891

import socket #nao is a client
import time

def StiffnessOn(proxy):
    pNames = "Body"
    pStiffnessLists = 1.0
    pTimeLists = 1.0
    proxy.stiffnessInterpolation(pNames, pStiffnessLists, pTimeLists)
    

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

                received = data.decode("utf8")
                received = received.lower()
                
                self.log("Client sent the data : {}".format(str(received)))


                if received == "":
                    self.log(received)
                elif received == "close":
                    id = self.tts.pCall("say", str("Chiuderò il server alla disconnessione dell'app"))
                    self.ids.append(id)
                    active = False
                    self.log("Closing the Socket.")
                elif received == "quando sei nato?":
                    id = self.tts.pCall("say", str("Nacqui nel 1891"))
                    self.ids.append(id)
                elif received == "dove sei nato?":
                    id = self.tts.pCall("say", str("Nacqui nel 1891 a Popoli, comune allora della provincia dell Aquila, oggi di Pescara in Abruzzo,"))
                elif received == "dove abitavi?":
                    id = self.tts.pCall("say", str("Il palazzo della mia famiglia si trova sul corso Gramsci, al tempo corso Vittorio Emanuele, allangolo con via Venezia"))
                elif received == "dove hai studiato?":
                    id = self.tts.pCall("say", str("Frequentai l'Istituto Tecnico Ferdinando Galiani di Chieti,in seguito al diploma mi trasferì a Torino iscrivendomi al Regio Istituto Superiore dIngegneria che allepoca rappresentava il massimo nel campo dellingegneria meccanica."))
                    self.ids.append(id)
                elif received == "quali sono state le tue creazioni?":
                    id = self.tts.pCall("say", str("Le mie creazioni principali sono stati i miei elicotteri e l'iconica Vespa, oggi però vi vorrei parlare dei miei elicotteri. Ti va bene? Rispondimi con si o no"))
                    data = client.recv(2048)
                    received = data.decode("utf8")
                    received = received.lower()
                    if received == "si" or received == "sì":
                        id = self.tts.pCall("say", str("Il mio ultimo prototipo è stato il D'AT 3, commissionatomi dal Ministrero dell'Aeronautica Militare per un importo da seicentomila lire, con il quale riuscii a conseguire i seguenti record, durata del volo con ritorno senza scalo di 8 minuti e 45 secondi, distanza in linea retta senza scalo di metri  1078,60, altezza sul punto di partenza di metri 18"))
                    if received == "no":
                        id = self.tts.pCall("say", str("Va bene, sarà per la prossima."))
                elif received == "mostrami il tuo elicottero":
                    id = self.tts.pCall("say", str("Ok, spero ti piaccia!"))
                    client.send(bytes("showtime"))

                names = list()
                times = list()
                keys = list()

                names.append("HeadPitch")
                times.append([0.56, 0.84, 1.24, 1.48, 2.16])
                keys.append([-0.100833, 0.0146303, -0.587509, -0.311747, -0.341671])

                names.append("HeadYaw")
                times.append([0.56, 0.84, 1.24, 1.48, 2.16])
                keys.append([0.0689882, 0.0843279, 0.124212, 0.102736, 0.0904641])

                names.append("LElbowRoll")
                times.append([0.52, 0.88, 1.16, 1.56, 2.24])
                keys.append([-1.38056, -1.54462, -1.40203, -0.93026, -0.811444])

                names.append("LElbowYaw")
                times.append([0.52, 0.88, 1.16, 1.56, 2.24])
                keys.append([-1.39845, -1.58536, -1.94974, -1.7195, -1.75339])

                names.append("LHand")
                times.append([0.52, 0.88, 1.16, 1.56, 2.24])
                keys.append([0.2484, 0.2496, 0.86, 0.76, 0.7656])

                names.append("LShoulderPitch")
                times.append([0.52, 0.88, 1.16, 1.56, 2.24])
                keys.append([1.02774, 0.806841, 0.466003, 0.254818, 0.757754])

                names.append("LShoulderRoll")
                times.append([0.52, 0.88, 1.16, 1.56, 2.24])
                keys.append([0.430625, 0.321678, 0.886873, 1.08857, 1.07441])

                names.append("LWristYaw")
                times.append([0.52, 0.88, 1.16, 1.56, 2.24])
                keys.append([-0.679603, -0.526205, -0.851412, -0.805393, -1.07998])

                names.append("RElbowRoll")
                times.append([0.52, 0.76, 1.28, 1.6, 2.2])
                keys.append([1.35917, 1.53864, 1.42666, 0.93026, 0.782382])

                names.append("RElbowYaw")
                times.append([0.52, 0.76, 1.28, 1.6, 2.2])
                keys.append([1.57204, 1.71905, 2.08708, 2.02107, 2.05334])

                names.append("RHand")
                times.append([0.52, 0.76, 1.28, 1.6, 2.2])
                keys.append([0.056, 0.05, 0.86, 0.76, 0.774])

                names.append("RShoulderPitch")
                times.append([0.52, 0.76, 1.28, 1.6, 2.2])
                keys.append([1.2027, 0.826867, 0.466003, 0.254818, 0.716419])

                names.append("RShoulderRoll")
                times.append([0.52, 0.76, 1.28, 1.6, 2.2])
                keys.append([-0.456545, -0.380752, -1.03936, -1.04396, -0.985401])

                names.append("RWristYaw")
                times.append([0.52, 0.76, 1.28, 1.6, 2.2])
                keys.append([0.432547, 0.406468, 0.521518, 0.59515, 0.987855])

                motion = ALProxy("ALMotion")
                motion.angleInterpolation(names, keys, times, True)

                names = list()
                times = list()
                keys = list()

                names.append("HeadPitch")
                times.append([0.4, 1.32])
                keys.append([0.0436332, 0.0459781])

                names.append("HeadYaw")
                times.append([0.4, 1.32])
                keys.append([0.0894078, 0.095628])

                names.append("LAnklePitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.075124, 0.049046, 0.049046, 0.075124])

                names.append("LAnkleRoll")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([-0.06592, -0.075124, -0.075124, -0.06592])

                names.append("LElbowRoll")
                times.append([0.36, 0.64, 0.92, 1.36])
                keys.append([-0.906552, -0.87127, -0.87127, -0.868286])

                names.append("LElbowYaw")
                times.append([0.36, 0.64, 0.92, 1.36])
                keys.append([-0.96186, -1.34565, -0.940383, -0.803775])

                names.append("LHand")
                times.append([0.36, 0.64, 0.92, 1.36])
                keys.append([0.1836, 0.59, 0.1956, 0.2224])

                names.append("LHipPitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.231675, 0.316046, 0.316046, 0.231675])

                names.append("LHipRoll")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.0583338, 0.0890141, 0.0890141, 0.0583338])

                names.append("LHipYawPitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([-0.328234, -0.328234, -0.328234, -0.328234])

                names.append("LKneePitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([-0.0598679, -0.04913, -0.04913, -0.0598679])

                names.append("LShoulderPitch")
                times.append([0.36, 0.64, 0.92, 1.36])
                keys.append([1.39897, 1.39897, 1.39897, 1.33155])

                names.append("LShoulderRoll")
                times.append([0.36, 0.64, 0.92, 1.36])
                keys.append([-0.0782759, 0.0292214, -0.0138481, -0.0413762])

                names.append("LWristYaw")
                times.append([0.36, 0.64, 0.92, 1.36])
                keys.append([0.093532, 0.00455999, 0.0459781, 0.0123138])

                names.append("RAnklePitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.038392, -0.0122299, -0.0122299, 0.038392])

                names.append("RAnkleRoll")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.177985, 0.177985, 0.177985, 0.177985])

                names.append("RElbowRoll")
                times.append([0.32, 0.56, 0.92, 1.28])
                keys.append([0.992539, 0.967996, 0.992539, 1.06302])

                names.append("RElbowYaw")
                times.append([0.32, 0.56, 0.92, 1.28])
                keys.append([0.94797, 1.34565, 0.937231, 0.796188])

                names.append("RHand")
                times.append([0.32, 0.56, 0.92, 1.28])
                keys.append([0.1648, 0.59, 0.1648, 0.1888])

                names.append("RHipPitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.182504, 0.285283, 0.285283, 0.182504])

                names.append("RHipRoll")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([-0.190175, -0.200912, -0.200912, -0.190175])

                names.append("RHipYawPitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([-0.328234, -0.328234, -0.328234, -0.328234])

                names.append("RKneePitch")
                times.append([0.36, 0.6, 0.96, 1.24])
                keys.append([0.021518, 0.032256, 0.032256, 0.021518])

                names.append("RShoulderPitch")
                times.append([0.32, 0.56, 0.92, 1.28])
                keys.append([1.46041, 1.46041, 1.46041, 1.49714])

                names.append("RShoulderRoll")
                times.append([0.32, 0.56, 0.92, 1.28])
                keys.append([0.0628521, -0.0519611, -0.038392, -0.0674542])

                names.append("RWristYaw")
                times.append([0.32, 0.56, 0.92, 1.28])
                keys.append([-0.204064, -0.204064, -0.204064, -0.233125])

                motion = ALProxy("ALMotion")
                motion.angleInterpolation(names, keys, times, True)

                names = list()
                times = list()
                keys = list()

                names.append("HeadPitch")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[-0.199447, [3, -0.2, 0], [3, 0.12, 0]], [-0.24975, [3, -0.12, 0], [3, 0.0666667, 0]], [0.0383972, [3, -0.0666667, 0], [3, 0.106667, 0]], [-0.233874, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.0366519, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.12913, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LAnklePitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[0.0766945, [3, -0.173333, 0], [3, 0.12, 0]], [0.0918305, [3, -0.12, -0.00540429], [3, 0.0666667, 0.00300238]], [0.101914, [3, -0.0666667, 0], [3, 0.106667, 0]], [0.101914, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.101914, [3, -0.0666667, 0], [3, 0.0933333, 0]], [0.0916034, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LAnkleRoll")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[-0.0743744, [3, -0.173333, 0], [3, 0.12, 0]], [-0.0899801, [3, -0.12, 0.00549532], [3, 0.0666667, -0.00305295]], [-0.100019, [3, -0.0666667, 0.00268], [3, 0.106667, -0.004288]], [-0.110884, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.110884, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.110884, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LElbowRoll")
                times.append([0.64, 1, 1.2, 1.52, 1.72, 2])
                keys.append([[-1.54152, [3, -0.226667, 0], [3, 0.12, 0]], [-1.54152, [3, -0.12, 0], [3, 0.0666667, 0]], [-1.54152, [3, -0.0666667, 0], [3, 0.106667, 0]], [-1.44375, [3, -0.106667, -0.0514212], [3, 0.0666667, 0.0321382]], [-1.29084, [3, -0.0666667, -0.0408674], [3, 0.0933333, 0.0572143]], [-1.14951, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LElbowYaw")
                times.append([0.64, 1, 1.2, 1.52, 1.72, 2])
                keys.append([[-1.18948, [3, -0.226667, 0], [3, 0.12, 0]], [-1.01033, [3, -0.12, -0.0480144], [3, 0.0666667, 0.0266747]], [-0.965408, [3, -0.0666667, 0], [3, 0.106667, 0]], [-1.04688, [3, -0.106667, 0], [3, 0.0666667, 0]], [-1.04688, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-1.04688, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LHand")
                times.append([0.64, 1, 1.2, 1.52, 1.72, 2])
                keys.append([[0.865834, [3, -0.226667, 0], [3, 0.12, 0]], [0.854073, [3, -0.12, 0.00477493], [3, 0.0666667, -0.00265274]], [0.843551, [3, -0.0666667, 0.00693243], [3, 0.106667, -0.0110919]], [0.8, [3, -0.106667, 0.043551], [3, 0.0666667, -0.0272194]], [0.592788, [3, -0.0666667, 0.0588075], [3, 0.0933333, -0.0823305]], [0.376586, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LHipPitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[0.13224, [3, -0.173333, 0], [3, 0.12, 0]], [0.0423754, [3, -0.12, 0.0292209], [3, 0.0666667, -0.0162338]], [-0.00412397, [3, -0.0666667, 0.0105407], [3, 0.106667, -0.0168651]], [-0.0398422, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.0345662, [3, -0.0666667, -0.0239221], [3, 0.0933333, 0.033491]], [0.132397, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LHipRoll")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[0.0313472, [3, -0.173333, 0], [3, 0.12, 0]], [0.0448106, [3, -0.12, 0], [3, 0.0666667, 0]], [0.0448106, [3, -0.0666667, 0], [3, 0.106667, 0]], [0.0556559, [3, -0.106667, -0.00523724], [3, 0.0666667, 0.00327328]], [0.0703422, [3, -0.0666667, -0.00391245], [3, 0.0933333, 0.00547742]], [0.0838255, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LHipYawPitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[-0.17217, [3, -0.173333, 0], [3, 0.12, 0]], [-0.17217, [3, -0.12, 0], [3, 0.0666667, 0]], [-0.18217, [3, -0.0666667, 0.00273815], [3, 0.106667, -0.00438104]], [-0.193527, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.193527, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.180703, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LKneePitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[-0.0828396, [3, -0.173333, 0], [3, 0.12, 0]], [-0.0828396, [3, -0.12, 0], [3, 0.0666667, 0]], [-0.0828396, [3, -0.0666667, 0], [3, 0.106667, 0]], [-0.0828396, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.0828396, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.0828396, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LShoulderPitch")
                times.append([0.64, 1, 1.2, 1.52, 1.72, 2])
                keys.append([[1.39286, [3, -0.226667, 0], [3, 0.12, 0]], [1.23729, [3, -0.12, 0.0392063], [3, 0.0666667, -0.0217813]], [1.2099, [3, -0.0666667, 0], [3, 0.106667, 0]], [1.25943, [3, -0.106667, -0.0123487], [3, 0.0666667, 0.00771794]], [1.2701, [3, -0.0666667, -0.00451047], [3, 0.0933333, 0.00631466]], [1.2919, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LShoulderRoll")
                times.append([0.64, 1, 1.2, 1.52, 1.72, 2])
                keys.append([[0.128563, [3, -0.226667, 0], [3, 0.12, 0]], [0.105838, [3, -0.12, 0.00787665], [3, 0.0666667, -0.00437591]], [0.0918054, [3, -0.0666667, 0.00774465], [3, 0.106667, -0.0123914]], [0.0454297, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.134857, [3, -0.0666667, -0.0231743], [3, 0.0933333, 0.032444]], [0.212284, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("LWristYaw")
                times.append([0.64, 1, 1.2, 1.52, 1.72, 2])
                keys.append([[-0.366798, [3, -0.226667, 0], [3, 0.12, 0]], [-0.767362, [3, -0.12, 0.127013], [3, 0.0666667, -0.070563]], [-0.959528, [3, -0.0666667, 0.0465419], [3, 0.106667, -0.074467]], [-1.13039, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.683602, [3, -0.0666667, -0.143259], [3, 0.0933333, 0.200563]], [-0.0989207, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RAnklePitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[0.0838159, [3, -0.173333, 0], [3, 0.12, 0]], [0.0977339, [3, -0.12, -0.0055546], [3, 0.0666667, 0.00308589]], [0.109737, [3, -0.0666667, 0], [3, 0.106667, 0]], [0.109737, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.0984168, [3, -0.0666667, 0.00331651], [3, 0.0933333, -0.00464312]], [0.0858585, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RAnkleRoll")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[0.157215, [3, -0.173333, 0], [3, 0.12, 0]], [0.130653, [3, -0.12, 0.00819488], [3, 0.0666667, -0.00455271]], [0.118972, [3, -0.0666667, 0], [3, 0.106667, 0]], [0.118972, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.118972, [3, -0.0666667, 0], [3, 0.0933333, 0]], [0.118972, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RElbowRoll")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[1.50369, [3, -0.2, 0], [3, 0.12, 0]], [1.53167, [3, -0.12, 0], [3, 0.0666667, 0]], [1.53167, [3, -0.0666667, 0], [3, 0.106667, 0]], [1.1342, [3, -0.106667, 0.0983277], [3, 0.0666667, -0.0614548]], [1.05232, [3, -0.0666667, 0.0153759], [3, 0.0933333, -0.0215262]], [1.02349, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RElbowYaw")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[1.19153, [3, -0.2, 0], [3, 0.12, 0]], [0.996394, [3, -0.12, 0.0495841], [3, 0.0666667, -0.0275467]], [0.960135, [3, -0.0666667, 0], [3, 0.106667, 0]], [1.02628, [3, -0.106667, -0.0165271], [3, 0.0666667, 0.0103294]], [1.0407, [3, -0.0666667, -0.00349041], [3, 0.0933333, 0.00488658]], [1.05141, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RHand")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[0.618988, [3, -0.2, 0], [3, 0.12, 0]], [0.456782, [3, -0.12, 0.0538592], [3, 0.0666667, -0.0299218]], [0.367645, [3, -0.0666667, 0.0195713], [3, 0.106667, -0.0313141]], [0.304126, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.304126, [3, -0.0666667, 0], [3, 0.0933333, 0]], [0.304126, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RHipPitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[0.119026, [3, -0.173333, 0], [3, 0.12, 0]], [0.0441397, [3, -0.12, 0.0242135], [3, 0.0666667, -0.0134519]], [0.00602971, [3, -0.0666667, 0.00826778], [3, 0.106667, -0.0132285]], [-0.020349, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.0448721, [3, -0.0666667, -0.0209684], [3, 0.0933333, 0.0293557]], [0.130623, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RHipRoll")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[-0.152361, [3, -0.173333, 0], [3, 0.12, 0]], [-0.110088, [3, -0.12, -0.0120535], [3, 0.0666667, 0.00669639]], [-0.0961113, [3, -0.0666667, -0.00331221], [3, 0.106667, 0.00529954]], [-0.0842526, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.0842526, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.0842526, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RHipYawPitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[-0.17217, [3, -0.173333, 0], [3, 0.12, 0]], [-0.17217, [3, -0.12, 0], [3, 0.0666667, 0]], [-0.18217, [3, -0.0666667, 0.00273815], [3, 0.106667, -0.00438104]], [-0.193527, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.193527, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.180703, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RKneePitch")
                times.append([0.48, 0.84, 1.04, 1.36, 1.56, 1.84])
                keys.append([[-0.0789128, [3, -0.173333, 0], [3, 0.12, 0]], [-0.0789128, [3, -0.12, 0], [3, 0.0666667, 0]], [-0.0789128, [3, -0.0666667, 0], [3, 0.106667, 0]], [-0.0789128, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.0789128, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.0789128, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RShoulderPitch")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[1.27026, [3, -0.2, 0], [3, 0.12, 0]], [1.22335, [3, -0.12, 0.0122249], [3, 0.0666667, -0.00679162]], [1.21321, [3, -0.0666667, 0], [3, 0.106667, 0]], [1.29353, [3, -0.106667, -0.0269722], [3, 0.0666667, 0.0168576]], [1.3447, [3, -0.0666667, -0.0134558], [3, 0.0933333, 0.0188381]], [1.39042, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RShoulderRoll")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[-0.152328, [3, -0.2, 0], [3, 0.12, 0]], [-0.189133, [3, -0.12, 0.0111154], [3, 0.0666667, -0.00617522]], [-0.2042, [3, -0.0666667, 0], [3, 0.106667, 0]], [-0.2042, [3, -0.106667, 0], [3, 0.0666667, 0]], [-0.214939, [3, -0.0666667, 0], [3, 0.0933333, 0]], [-0.214939, [3, -0.0933333, 0], [3, 0, 0]]])

                names.append("RWristYaw")
                times.append([0.56, 0.92, 1.12, 1.44, 1.64, 1.92])
                keys.append([[-0.380616, [3, -0.2, 0], [3, 0.12, 0]], [0.362683, [3, -0.12, -0.242019], [3, 0.0666667, 0.134455]], [0.748807, [3, -0.0666667, -0.0976277], [3, 0.106667, 0.156204]], [1.12418, [3, -0.106667, 0], [3, 0.0666667, 0]], [0.697461, [3, -0.0666667, 0.139932], [3, 0.0933333, -0.195905]], [0.116665, [3, -0.0933333, 0], [3, 0, 0]]])

                motion = ALProxy("ALMotion")
                motion.angleInterpolationBezier(names, times, keys)


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
    