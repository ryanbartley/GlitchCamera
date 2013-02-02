void serialEvent(Serial myPort) { 

  if (firstContact == false) {
    char inByte = (char)myPort.read();
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } 
  else {

    // read the serial buffer:
    String myString = myPort.readStringUntil('\n');
    if (myString != null) {
      myString = trim(myString);

      // split the string at the commas
      // and convert the sections into integers:
      int sensors[] = int(split(myString, ','));

      // print out the values you got:
//            for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
//              print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
//            }
       //add a linefeed after all the sensor values are printed:
//            println();

      if (sensors.length > 1) {
//        xpos = (int)map(sensors[0], 300, 400, -30, 30);
//        ypos = (int)map(sensors[1], 300, 400, -30, 30);
//        zpos = (int)map(sensors[2], 300, 400, -30, 30);
        takePicture = sensors[0];
        deletePicture = sensors[1];
        glitchPicture1 = sensors[2];
        glitchPicture2 = sensors[3];
        glitchPicture3 = sensors[4];
        glitchPicture4 = sensors[5];
        sendPicture = sensors[6];
        resetCamera = sensors[7];
      }
    }
  }
  myPort.write('A');
}

