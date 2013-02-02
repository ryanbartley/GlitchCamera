void reset() {
  
  picture = false;
  enteredName = false;
  imgFileName = "";
  userName = "";
  fromName = "glitchcamera@gmail.com";
  emailAddress = "";
  fileType = ".jpg";
  subject = "YOU TOOK PICTURES!!!!!!";
  message = "These are the pictures you took using our FUCKING GLITCH CAM!!!!!!!!!!!!! ";
  level = 0;
  keyValue = 1000;
  key = 'z'; 
  String emailFile = "";
  
  emailFileNames = new ArrayList<String>();
  

  loops = 1;
  blackValue = -10000000;
  brigthnessValue = 60;
  whiteValue = -6000000;
  row = 0;
  column = 0;
  saved = false;
  mode = 1;
  
  
//  cp5.get(Textfield.class,"userName").clear();
  background(0);
  cp5.show();
  
  //cam.start();
  
}
