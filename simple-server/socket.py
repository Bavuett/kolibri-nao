import socket

def generateBytes(value):
    ToSend = bytes(value, "utf-8")
    return ToSend

active = True
# For tcp
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# To fix the address already in use issue
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# Bind to all the interfaces on port 8080
sock.bind(("0.0.0.0", 8080))
# Number of backlog clients
sock.listen(2)
print("Welcome! Waiting for Client...")
while active == True:
    (client, (ip, port)) = sock.accept()
    print('\nClient connected with IP as {} and Port {}'.format(ip, port))
    data = client.recv(2048)

    while len(data):
        received = data.lower().decode("utf8")

        print("Client sent '{}'".format(str(received)))

        if received == "":
            print(received)
        elif received == "close":
            active = False
            print("\nI'll close the Socket when the Client closes his connection.")
        elif received == "mostrami":
            client.send(generateBytes("showtime"))

            message = input(str("Send a custom message: "))
            client.send(generateBytes(message))
        
        data = client.recv(2048)
    print("\nClient closed the connection.")
    client.close()


print("Closing the Socket.")
sock.close()


