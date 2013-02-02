void enteringEmail() {
  background(0);
  image(titleCard, 0, 0);
  fill(255);
  text(userName, 360, 180);
  //enterName();
  if (key == ENTER) {
    emailAddress = userName;
    
    imgFileName = userName;
    cp5.get(Textfield.class,"userName").clear();
    enteredName = true;
    cp5.hide();
    cam.start();
    key = 'z';
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
}

