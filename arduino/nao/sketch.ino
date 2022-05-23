// Web Server con Arduino + Interruttori con Arduino --- Progetto NAO-Challenge ---

#include <DhcpV2_0.h>
#include <DnsV2_0.h>
#include <EthernetClientV2_0.h>
#include <EthernetServerV2_0.h>
#include <EthernetUdpV2_0.h>
#include <utilV2_0.h>
#include <SPI.h>
#include <EthernetV2_0.h>

#define W5200_CS  10
#define SDCARD_CS 4

#define SS 10   
#define nRST 8  
#define nPWDN 9  
#define nINT 3  

byte mac[]{ 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
IPAddress IP{192, 168, 1, 50};
IPAddress gateway{192, 168, 1, 1};
IPAddress subnet{255, 255, 255, 0};

EthernetServer Aurum(90), Aurum2(80);

char Interruttori();
void AccendiLED(char s);
void SpegniLED();

void setup() {
  //interfaccia scheda SD
  pinMode(SDCARD_CS, OUTPUT);
  digitalWrite(SDCARD_CS, HIGH);
  
  //inizializzazione scheda ethernet
  pinMode(SS,OUTPUT);  
  pinMode(nRST,OUTPUT);
  pinMode(nPWDN,OUTPUT);
  pinMode(nINT,INPUT); 
  digitalWrite(nPWDN,LOW);  
  digitalWrite(nRST,LOW);  
  delay(50);
  digitalWrite(nRST,HIGH); 
  delay(100);


  //inizializzazione server
  Serial.begin(9600);
  delay(500);
  Serial.println("\n --- WebServer Arduino Ethernet --- ");
  Ethernet.begin(mac, IP, gateway, subnet);
  Serial.print("il mio IP è "); 
  Serial.print(Ethernet.localIP());
  Serial.print("\nMi sto preparando ...");
  Aurum.begin();
  Aurum2.begin();
  delay(500);
  Serial.print("\t\t Sono pronto: ");

  //inizializzazione pin
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
}

void loop(){  
  char s=' ';
  int cont=0;
  
  EthernetClient cl2; //client2
  EthernetClient cl1 = Aurum.available(); //client1
  
  if(cl1){
    Serial.print("\n client1 connesso !!");
    while(cl1.connected()){
      digitalWrite(6, HIGH);
      s=' ';
      
      char c=cl1.read(); //carattere scartato
      
      //cerco la stanza dall'app
      cl2 = Aurum2.available();
      while(cl2.connected()){
        Serial.println("\n\t client2 connesso !!");  
        digitalWrite(7, HIGH);
        delay(1000);
        s=cl2.read();
        Serial.print("S=");
        Serial.print(s);
        Serial.print(";");      
        delay(100);   
        
        //Serial.print("\n\t client2 disconnesso !!");
        if((s=='A') || (s=='B') || (s=='C') || (s=='D')){
          cl1.print(s);
          AccendiLED(s);
          cl2.stop();
          Serial.print("\n\t client2 disconnesso !!");
        }
      }
      digitalWrite(7, LOW);

      s=Interruttori();
      
      //elaboro la stanza
      if((s=='A') || (s=='B') || (s=='C') || (s=='D')){
        cl1.print(s);
        AccendiLED(s);
        Serial.print("\n\t Dati invitai !!");
      }
      
    }
    delay(10);
    cl1.stop();
    Serial.print("\n client1 disconnesso");
    delay(150);
  }

  digitalWrite(6, LOW);
  delay(500);
}

//--------------------------------------------------------------------------------

char Interruttori(){
  char s=' ';
  if(analogRead(A0)>=240){
    s='A';
  }
  if(analogRead(A1)>=240){
    s='B';
  }
  if(analogRead(A2)>=240){
    s='C';
  }
  if(analogRead(A3)>=240){
    s='D';
  }  
  if(s!=' '){
    Serial.print("Hai premuto: ");
    Serial.print(s);
    Serial.println("; ");
  }
  return s;
}

void AccendiLED(char s){
  SpegniLED();
  switch(s){  
    case 'A': digitalWrite(2, HIGH); Serial.print("\n LED ACCESO - 2"); break;
    case 'B': digitalWrite(3, HIGH); Serial.print("\n LED ACCESO - 3"); break;
    case 's': digitalWrite(4, HIGH); Serial.print("\n LED ACCESO - 4"); break;
    case 'D': digitalWrite(5, HIGH); Serial.print("\n LED ACCESO - 5"); break;
    }
    delay(500);     
}

void SpegniLED(){
  digitalWrite(2, LOW);  
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
}
