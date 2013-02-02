void jpgGlitch () {
  level++;
  img.save("data/" + imgFileName + "_" + level + fileType);
  byte raw[] = loadBytes(imgFileName + "_" + level + fileType);
  int j = 0;
  // skip the jpeg header
  while (! (raw[j] == (byte) 0xff && raw[j+1] == (byte) 0xda) &&
    j < raw.length - 1) {
    j++;
  }
  // modify the remaining bytes
  while (j < raw.length) {
    if (raw[j] == 10) {
      raw[j]++;
    }
    j+=40;
  }
  saveBytes("data/" + imgFileName + "_" + level + fileType, raw);
  img = loadImage("data/" + imgFileName + "_" + level + fileType);
  emailFileNames.add("data/" + imgFileName + "_" + level + fileType);
}
