import processing.video.*;
import controlP5.*;
import javax.activation.*;
import processing.serial.*;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

Capture cam;
ControlP5 cp5;
Serial myPort; 
ArrayList<String> emailFileNames = new ArrayList<String>();

//overall variables
boolean picture;
boolean enteredName;
PImage img;
PImage img2;
PImage titleCard;
String imgFileName;
String userName;
String fromName;
String emailAddress;
String fileType;
String subject;
String message;
int level;
int keyValue;

Textlabel myTextlabelA;
int[] serialInArray = new int[3];
int serialCount;
boolean firstContact; 
String emailFile;

//Arduino Values
int xpos;
int ypos;
int zpos;
int takePicture;
int deletePicture;
int glitchPicture1;
int glitchPicture2;
int glitchPicture3;
int glitchPicture4;
int sendPicture;
int resetCamera;

//pixelSort variables
int loops;
int blackValue;
int brigthnessValue;
int whiteValue;
int row;
int column;
boolean saved;
int mode;


void setup() {
  size(800, 600);
  titleCard = loadImage("title.jpg");
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

  String emailFile = "";
  firstContact = false;


  loops = 1;
  blackValue = -10000000;
  brigthnessValue = 60;
  whiteValue = -6000000;
  row = 0;
  column = 0;
  saved = false;
  mode = 1;



  PFont font = createFont("arial", 20);
  cp5 = new ControlP5(this);

  cp5.addTextfield("userName")
    .setPosition(width/2 - 120, height/2)
      .setSize(200, 40)
        .setFont(createFont("arial", 20))
          .setAutoClear(false);

  myTextlabelA = cp5.addTextlabel("label")
    .setText("Please enter your email address and press Return.")
      .setPosition(160, 258)
        .setColorValue(0xffffff00)
          .setFont(createFont("Georgia", 20));

  //println(Capture.list());
  cam = new Capture(this, Capture.list()[18]);
  cam.start();

  //Serial Start
  //println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  //myPort.bufferUntil('\n');
}

void draw() {

  if (enteredName == false) {
    enteringEmail();
    //println(userName);
  }

  if (cam.available() == true && picture == false && enteredName == true) {
    cam.read();
    image(cam, 0, 0);

    if (takePicture == 1) {
      level = 0;
      save("data/" + imgFileName + "_" + level + fileType);
      img = loadImage("data/" + imgFileName + "_" + level + fileType);
      emailFile = "data/" + imgFileName + "_" + level + fileType;
      emailFileNames.add(emailFile);
      picture = true;
    }
  }

  if (picture == true) {
    cam.stop();
    image(img, 0, 0);

    if (deletePicture == 1) {
      keyValue = 0;
    }
    else if (glitchPicture1 == 1) {
      keyValue = 1;
    }
    else if (glitchPicture2 == 1) {
      keyValue = 2;
    } 
    else if (glitchPicture3 == 1) {
      keyValue = 3;
    } 
    else if (glitchPicture4 == 1) {
      keyValue = 4;
    } 
    else if (sendPicture == 1) {
      keyValue = 5;
    }
    else if (resetCamera == 1) {
      keyValue = 6;
    }

    switch(keyValue) {
    case 0:
      picture = false;
      level = 0;
      cam.start();
      emailFileNames = new ArrayList<String>();
      keyValue = 1000;
      break;
    case 1:
      jpgGlitch();
      keyValue = 1000;
      break;
    case 2:
      pixelSort();
      keyValue = 1000;
      break;
    case 3:
      img2 = crashGlitch(img);
      img = img2;
      image(img, 0, 0);
      save("data/" + imgFileName + "_" + level + fileType);
      img = loadImage("data/" + imgFileName + "_" + level + fileType);
      emailFileNames.add("data/" + imgFileName + "_" + level + fileType);
      keyValue = 1000;
      break;
    case 4:
      minimalCGlitch();
      keyValue = 1000;
      break;
    case 5:
      SendMail sendMail = new SendMail(fromName, userName, subject, message, imgFileName, emailFileNames);
      sendMail.send();
      keyValue = 1000;
      break;
    case 6:
      reset();
      keyValue = 1000;
      break;
    default:
      keyValue = 1000;
      break;
    }
  }
  //  println(imgFileName + "_" + level + fileType);
}

