//PUNYA ESP32
#include <WiFi.h>
#include <IOXhop_FirebaseESP32.h>
#define FIREBASE_HOST ""
#define FIREBASE_AUTH ""
#define WIFI_SSID "JTE-2"
#define WIFI_PASSWORD "elektro2"

//PUNYA ULTRASONIC
const int trigPin = 2;
const int echoPin = 15;
long duration;
int distance;
int ketinggianAir;

//PUNYA TDS
#define analogInPin 27
int sensorValue;
float outputValueConductivity;
float outputValueTDS;

//PUNYA PH METER
#define SensorPin 35         
unsigned long int avgValue;  
float b;
int buf[10],temp;
float phValue;

void setup() {
  Serial.begin(115200);

//PUNYA ESP32
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);  

//PUNYA ULTRASONIC
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
}

void loop() {
  ultrasonic();
  tds();
  phMeter();
  sendDataFirebase();
  delay(1000);
}

void ultrasonic(){
  digitalWrite(trigPin, LOW); //KONFIGURASI ULTRASONIC
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance= duration*0.034/2;
  
  Serial.print("Jarak: ");
  Serial.println(distance); //TAMPILKAN JARAK ANTARA ULTRASONIC DAN BENDA
  ketinggianAir = 20 - distance; //RUMUS MENGUKUR KETINGGIAN AIR
  Serial.print("Ketinggian Air: ");
  Serial.println(ketinggianAir); //TAMPILKAN KETINGGIAN AIR
}

void tds(){
  sensorValue = analogRead(analogInPin);
  outputValueConductivity = (0.2142*sensorValue)+494.93;
  outputValueTDS = (0.3417*sensorValue)+281.08;
  Serial.print("sensor ADC = ");
  Serial.print(sensorValue);
  Serial.print("  conductivity (uSiemens)= ");
  Serial.print(outputValueConductivity);
  Serial.print("  TDS(ppm)= ");
  Serial.println(outputValueTDS);
}

void phMeter(){
  for(int i=0;i<10;i++){ 
    buf[i]=analogRead(SensorPin);
    delay(10);
  }
  for(int i=0;i<9;i++){
    for(int j=i+1;j<10;j++){
      if(buf[i]>buf[j]){
        temp=buf[i];
        buf[i]=buf[j];
        buf[j]=temp;
      }
    }
  }
  avgValue=0;
  for(int i=2;i<8;i++)                      
  avgValue+=buf[i];
  phValue = (float)avgValue*5.0/4096/6;
  phValue = 3.0*phValue;                      
  Serial.print("pH = ");  
  Serial.println(phValue,2);
}

void sendDataFirebase(){
  Firebase.setInt("realtime_monitoring/ketinggian_air", ketinggianAir);
  Firebase.setFloat("realtime_monitoring/tds", outputValueTDS);
  Firebase.setFloat("realtime_monitoring/ph_meter", phValue);
}
