/*
  AnalogReadSerial
 Reads an analog input on pin 0, prints the result to the serial monitor.
 Attach the center pin of a potentiometer to pin A0, and the outside pins to +5V and ground.
 
 This example code is in the public domain.
 */

const int takePicture = 2;
const int deletePicture = 3;
const int glitchPicture1 = 4;
const int glitchPicture2 = 5;
const int glitchPicture3 = 8;
const int glitchPicture4 = 12;
const int sendPicture = 6;
const int resetCamera = 7;
const int deletePictureLED = 9;
const int sendPictureLED = 10;
const int resetCameraLED = 11;
int sensorValue, resetValue, deleteValue, takeValue;
int ledValue = LOW;
int inByte = 0; 


// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  pinMode(takePicture, INPUT);  // digital sensor is on digital pin 2
  pinMode(deletePicture, INPUT);
  pinMode(glitchPicture1, INPUT);
  pinMode(glitchPicture2, INPUT);
  pinMode(glitchPicture3, INPUT);
  pinMode(glitchPicture4, INPUT);
  pinMode(sendPicture, INPUT);  
  pinMode(resetCamera, INPUT);
  pinMode(deletePictureLED, OUTPUT);
  pinMode(sendPictureLED, OUTPUT);
  pinMode(resetCameraLED, OUTPUT);

  //  Serial.println();
  establishContact();
}

// the loop routine runs over and over again forever:
void loop() {

  if(resetValue == HIGH) {
    ledValue = LOW;
    establishContact(); 
  }

  if(deleteValue == HIGH) {
    ledValue = LOW;
  }

  if(takeValue == HIGH) {
    ledValue = HIGH;
  }

  digitalWrite(deletePictureLED, ledValue);
  digitalWrite(sendPictureLED, ledValue);
  digitalWrite(resetCameraLED, ledValue);

  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();

    //Xpos - Sensor[0]
    // read the input on analog pin 0:
    int sensorValue = analogRead(A0);
    // print out the value you read:
    Serial.print(sensorValue);
    Serial.print(",");
    delay(1); 

    //YPOS - Sensor[1]
    sensorValue = analogRead(A1);
    // print out the value you read:
    Serial.print(sensorValue);
    Serial.print(",");  
    delay(1); 

    //ZPOS - Sensor[2]
    sensorValue = analogRead(A2);
    // print out the value you read:
    Serial.print(sensorValue);
    Serial.print(","); 
    delay(1);        // delay in between reads for stability

    //takePicture - Sensor[3]
    takeValue = digitalRead(takePicture);  
    Serial.print(takeValue);
    Serial.print(",");
    delay(1);

    //deletePicture - Sensor[4]
    deleteValue = digitalRead(deletePicture);
    Serial.print(deleteValue);
    Serial.print(",");
    delay(1);

    //glitchPicture1 - Sensor[5]
    sensorValue = digitalRead(glitchPicture1);
    Serial.print(sensorValue);
    Serial.print(",");
    delay(1);

    //glitchPicture2 - Sensor[6]
    sensorValue = digitalRead(glitchPicture2);
    Serial.print(sensorValue);
    Serial.print(",");
    delay(1);

    //glitchPicture3 - Sensor[7]
    sensorValue = digitalRead(glitchPicture3);
    Serial.print(sensorValue);
    Serial.print(",");
    delay(1);

    //glitchPicture4 - Sensor[8]
    sensorValue = digitalRead(glitchPicture4);
    Serial.print(sensorValue);
    Serial.print(",");
    delay(1);

    //SendPicture - Sensor[9]
    sensorValue = digitalRead(sendPicture);
    Serial.print(sensorValue);
    Serial.print(",");
    delay(1);

    //SendPicture - Sensor[10]
    resetValue = digitalRead(resetCamera);
    Serial.println(resetValue);
    delay(1);

  }

}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.write('A');   // send a capital A
    Serial.println();
    delay(300);
  }
}



