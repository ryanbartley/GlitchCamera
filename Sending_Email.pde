class SendMail {
  private String from;
  private String to;
  private String subject;
  private String bodyText;
  private String fileNames;
  private ArrayList<String> emailFileNames = new ArrayList<String>();
  private String[] attachments;
  private File myFile;

  public SendMail(String _from, String _to, String _subject, String _text, 
  String _fileNames, ArrayList<String> _emailFileNames) {
    from = _from;
    to = _to;
    subject = _subject;
    bodyText = _text;
    fileNames = _fileNames;
    emailFileNames = _emailFileNames;
    myFile = new File(emailFileNames.get(0));
    System.out.println(to);
    System.out
      .println("This is the constructor and these are the values: from: "
      + from
      + " to: "
      + " subject: "
      + subject
      + " body: "
      + bodyText + " emailFiles: " + emailFileNames);
    // for (int i = 0; i < _fileNames.length; i ++) {
    // fileNames[i] = _fileNames[i]
    // }
  }

  public void send() {
    String host = "smtp.gmail.com";
    String userid = "glitchcamera";
    String password = "gl1tcam0";
    try {

      System.out.println("Starting to send...");
      Properties props = System.getProperties();
      props.put("mail.smtp.starttls.enable", "true");
      props.put("mail.smtp.host", host);
      props.setProperty("mail.transport.protocol", "smtps");
      props.put("mail.smtp.user", userid);
      props.put("mail.smtp.password", password);
      props.put("mail.smtp.port", "465");
      props.put("mail.smtps.auth", "true");
      Session session = Session.getDefaultInstance(props, null);
      MimeMessage message = new MimeMessage(session);
      InternetAddress fromAddress = null;
      InternetAddress toAddress = null;
      // MimeBodyPart messageBodyPart = new MimeBodyPart();
      // MimeMultipart multipart = new MimeMultipart("mixed");
      // multipart.addBodyPart(messageBodyPart);
      System.out.println("Set up the message...");
      System.out.println(emailFileNames);

      try {
        fromAddress = new InternetAddress(from);
        toAddress = new InternetAddress(to);
        System.out.println(fromAddress + " " + toAddress);
      } 
      catch (AddressException e) {

        e.printStackTrace();
      }

      message.setFrom(fromAddress);

      message.setRecipient(RecipientType.TO, toAddress);
      message.setSubject(subject);
      // message.setText(bodyText);

      // Part two is attachment
      // for ( int i = 0; i < emailFileNames.size(); i++ ) {
      // messageBodyPart = new MimeBodyPart();
      // FileDataSource fileDataSource =new
      // FileDataSource(emailFileNames.get(i));
      // messageBodyPart.setDataHandler(new DataHandler(fileDataSource));
      // messageBodyPart.setFileName(emailFileNames.get(i));
      // multipart.addBodyPart(messageBodyPart, i);
      // println("These are the file names: " + emailFileNames.get(i));
      // }

      // Put parts in message
      // message.setContent(multipart);
      // println(multipart);

      // FileDataSource source = new FileDataSource(myFile);
      // messageBodyPart.setDataHandler(new DataHandler(source));
      // messageBodyPart.setFileName(emailFileNames.get(0));
      // multipart.addBodyPart(messageBodyPart);

      Multipart multipart = new MimeMultipart("related");
      for (String str : emailFileNames) {
        System.out.println(str);
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        DataSource source = new FileDataSource("/Users/ryanbartley/Desktop/ITP/CLASSES/PCOMP/Midterm_6/" + str);
        System.out.println(source.getContentType());
        messageBodyPart.setDataHandler(new DataHandler(source));
        messageBodyPart.setFileName(source.getName());
        System.out.println(source.getName());
        multipart.addBodyPart(messageBodyPart);
      }
       
      System.out.println(multipart.getParent());
      message.setContent(multipart);
      System.out.println("Starting to send...");
      Transport transport = session.getTransport("smtps");
      transport.connect(host, userid, password);
      System.out.println("Logged In...");
      System.out.println(message.getAllRecipients());
      message.setContent(multipart);
//      Transport.send(message);
      transport.sendMessage(message, message.getAllRecipients());
      transport.close();
    } 
    catch (MessagingException e) {
      e.printStackTrace();
    }
  }
}
