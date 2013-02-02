void minimalCGlitch() {
 img = loadImage("data/" + imgFileName + "_" + level + fileType);
 level++;
 int n = img.width * img.height;
  for (int i = 0; i < n; i++) {
    color cur = img.pixels[i];
    int r = int(red(cur)), g = int(green(cur)), b = int(blue(cur));
    int off = i*5&(i>>7)|i*3&(i*4>>10); // miiro
    off %= 256; // don't let the offset overflow
    // shuffle channels and xor with minimal c data
    img.pixels[i] = color(
      g ^ off,
      b ^ off,
      r ^ off);
  }
  updatePixels();
  save("data/" + imgFileName + "_" + level + fileType);
  img = loadImage("data/" + imgFileName + "_" + level + fileType);
  emailFileNames.add("data/" + imgFileName + "_" + level + fileType);
}
