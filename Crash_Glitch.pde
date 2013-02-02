PImage crashGlitch(PImage img) {
  //img = loadImage("data/" + imgFileName + "_" + level + fileType);
  
  level++;
  int n = img.width * img.height;
  for (int i = 0; i < n; i++) {
    color cur = img.pixels[i];
    int k = i % 400;
    int r = int(red(cur));
    int g = int(green(cur));
    int b = int(blue(cur));
   // println("original r: " + r + ", " + g + ", " + b);
    r = k^flipopp(k^flipnib(k^r));
    g = k^flipopp(k^flipnib(k^g));
    b = k^flipopp(k^flipnib(k^b));
  //  println(r + ", " + g + ", "+ b); 
    img.pixels[i] = color(r, g, b);
  }
  updatePixels();
  return img;
}

int flipnib(int x) {
  return ((x&15)<<4)|((x&240)>>4);
}
int flipopp(int x) {
  return ((x&170)>>1)|((x&85)<<1);
}

