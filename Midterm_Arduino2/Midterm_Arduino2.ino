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
int sensorValue, resetValue, deleteValue, takeValue, glitch1Value,
glitch2Value, glitch3Value, glitch4Value, sendValue;
int lastresetValue, lastdeleteValue, lasttakeValue, lastglitch1Value,
lastglitch2Value, lastglitch3Value, lastglitch4Value, lastsendValue;
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
  digitalWrite(deletePictureLED, HIGH);
  digitalWrite(sendPictureLED, HIGH);
  digitalWrite(resetCameraLED, HIGH);
  
  //  Serial.println();
  establishContact();
}

// the loop routine runs over and over again forever:
void loop() {

  if(resetValue != lastresetValue) {
    ledValue = HIGH;
//    establishContact(); 
  } else if (lasttakeValue == 1) {
    ledValue = LOW;
  }

  if(deleteValue != lastdeleteValue) {
    ledValue = HIGH;
  } else if (lasttakeValue == 1) {
    ledValue = LOW;
  }

  if(lasttakeValue == 1) {
    ledValue = LOW;
  }

  digitalWrite(deletePictureLED, ledValue);
  digitalWrite(sendPictureLED, ledValue);
  digitalWrite(resetCameraLED, ledValue);

  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();

    //takePicture - Sensor[0]
    takeValue = digitalRead(takePicture);
//    if (takeValue != lasttakeValue) {
      Serial.print(takeValue);
      Serial.print(",");
//      lasttakeValue = takeValue;
//    } else {
//      takeValue = 0;
//      Serial.print(takeValue);
//      Serial.print(",");
//    }
    delay(1);
    
    //deletePicture - Sensor[1]
    deleteValue = digitalRead(deletePicture);
    if (deleteValue != lastdeleteValue) {
      Serial.print(deleteValue);
      Serial.print(",");
      lastdeleteValue = deleteValue;
    } else {
      deleteValue = 0;
      Serial.print(deleteValue);
      Serial.print(",");
    }
    delay(1);

    //glitchPicture1 - Sensor[2]
    glitch1Value = digitalRead(glitchPicture1);
    if (glitch1Value != lastglitch1Value) {
      Serial.print(glitch1Value);
      Serial.print(",");
      lastglitch1Value = glitch1Value;
    } else {
      glitch1Value = 0;
      Serial.print(glitch1Value);
      Serial.print(",");
    }
    delay(1);

    //glitchPicture2 - Sensor[3]
    glitch2Value = digitalRead(glitchPicture2);
    if (glitch2Value != lastglitch2Value) {
      Serial.print(glitch2Value);
      Serial.print(",");
      lastglitch2Value = glitch2Value;
    } else {
      glitch2Value = 0;
      Serial.print(glitch2Value);
      Serial.print(",");
    }
    delay(1);

    //glitchPicture3 - Sensor[4]
    glitch3Value = digitalRead(glitchPicture3);
    if (glitch3Value != lastglitch3Value) {
      Serial.print(glitch3Value);
      Serial.print(",");
      lastglitch3Value = glitch3Value;
    } else {
      glitch3Value = 0;
      Serial.print(glitch3Value);
      Serial.print(",");
    }
    delay(1);

    //glitchPicture4 - Sensor[5]
    glitch4Value = digitalRead(glitchPicture4);
    if (glitch4Value != lastglitch4Value) {
      Serial.print(glitch4Value);
      Serial.print(",");
      lastglitch4Value = glitch4Value;
    } else {
      glitch4Value = 0;
      Serial.print(glitch4Value);
      Serial.print(",");
    }
    delay(1);

    //SendPicture - Sensor[6]
    sendValue = digitalRead(sendPicture);
    if (sendValue != lastsendValue) {
      Serial.print(sendValue);
      Serial.print(",");
      lastsendValue = sendValue;
    } else {
      sendValue = 0;
      Serial.print(sendValue);
      Serial.print(",");
    }
    delay(1);

    //ResetCamera - Sensor[7]
    resetValue = digitalRead(resetCamera);
    if (resetValue != lastresetValue) {
      Serial.println(resetValue);
      lastresetValue = resetValue;
    } else {
      resetValue = 0;
      Serial.println(resetValue);
    }
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






