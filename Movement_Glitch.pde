//void movement_Glitch() {
//  background(255);
//  loadPixels();  
//  for (int y = 0; y<height; y+=1 ) {
//    for (int x = 0; x<width; x+=1) {
//      int loc = x + y*img.width;
//      float r = red (img.pixels[loc]);
//      float g = green (img.pixels[loc]);
//      float b = blue (img.pixels[loc]);
//      float av = ((r+g+b)/3.0);
//      //color Color = color(r, g, b);
//      int grey = (int)(r+g+b)/3;
//      color Color =color(grey, grey, grey);
//      set(x, y, Color);
//
//
//      pushMatrix();
//      translate(x, y);
//      stroke(Color);
//      if (r > 100 && r < 255) {
//        line(0, 0, xpos, 0);
//      }
//      popMatrix();
//    }
//  }
//}

