import controlP5.*;

String version = "0.1.0";
int switchMode = 0; // 0=Jazz 1= Rock 2=Fusion
boolean playBass = false;
boolean playSnare = false;
boolean playTomTom1 = false;
boolean playTomTom2 = false;
boolean playHiHat = false;
boolean playRide = false;

void setup() {
  
  surface.setTitle("Drummey • " + "Version " + version);
  size(900, 600);
  frameRate(60);
  noStroke();
  
}


void draw() {
  background(142, 142, 142);
  
  PFont montserrat = loadFont("Gotham-Medium-48.vlw");
  textFont(montserrat);
  
  if(switchMode == 0) {
    drawJazz();
  }
}


void keyPressed() {
  if (key == ' ') playBass = true;
  if (key == 'a' || key == 'A') playSnare = true;
  if (key == 'w' || key == 'W') playTomTom1 = true;
  if (key == 'ä' || key == 'Ä') playTomTom2 = true;
  if (key == 'p' || key == 'P') playRide = true;
  if (key == 'd' || key == 'D') playHiHat = true;
}


void keyReleased() {
  if (key == ' ') playBass = false;
  if (key == 'a' || key == 'A') playSnare = false;
  if (key == 'w' || key == 'W') playTomTom1 = false;
  if (key == 'ä' || key == 'Ä') playTomTom2 = false;
  if (key == 'p' || key == 'P') playRide = false;
  if (key == 'd' || key == 'D') playHiHat = false;
}

void drawJazz() {
  fill(51, 51, 51);
  textSize(24);
  text("Jazz Drums", (width/2)-75, 50);
  // BASS ------------------------------
  fill(204, 204, 204);
  rect((width/2)-127.5, 257, 255, 8);
  fill(193, 39, 45);
  rect((width/2)-127.5, 265, 255, 100);
  fill(204, 204, 204);
  rect((width/2)-127.5, 365, 255, 8); 
  fill(51, 51, 51);
  rect((width/2)-25, 380, 50, 75);
  fill(76, 76, 76);
  rect((width/2)-25, 455, 50, 25);
  if(playBass == true) {
    fill(226, 134, 145);
    rect((width/2)-25, 380, 50, 75);
  }
  fill(198, 198, 198);
  textSize(12);
  text("SPACE", 429.5, 422);
  // SNARE ------------------------------
  fill(204, 204, 204);
  ellipse(280, 420, 140, 140);
  fill(199, 178, 153);
  ellipse(280, 420, 124, 124);
  if(playSnare == true) {
    fill(226, 134, 145);
    ellipse(280, 420, 124, 124);
  }
  fill(226, 208, 192);
  textSize(72);
  text("A", 252, 445);
  // TOMTOM 1 ------------------------------
  fill(204, 204, 204);
  ellipse(315, 350, 100, 100);
  fill(199, 178, 153);
  ellipse(315, 350, 84, 84);
  if(playTomTom1 == true) {
    fill(226, 134, 145);
    ellipse(315, 350, 84, 84);
  }
  fill(226, 208, 192);
  textSize(48);
  text("W", 289, 368);
  // TOMTOM 2 ------------------------------
  fill(204, 204, 204);
  ellipse(595, 360, 130, 130);
  fill(199, 178, 153);
  ellipse(595, 360, 114, 114);
  if(playTomTom2 == true) {
    fill(226, 134, 145);
    ellipse(595, 360, 114, 114);
  }
  fill(226, 208, 192);
  textSize(60);
  text("Ä", 571, 382);
  // HIHAT ------------------------------
  fill(226, 178, 59);
  ellipse(375, 280, 135, 135);
  fill(206, 162, 40);
  ellipse(375, 280, 119, 119);
  if(playHiHat == true) {
    fill(226, 134, 145);
    ellipse(375, 280, 119, 119);
  }
  fill(249, 204, 103);
  textSize(64);
  text("D", 353, 305);
  // RIDE ------------------------------
  fill(226, 178, 59);
  ellipse(520, 280, 135, 135);
  fill(206, 162, 40);
  ellipse(520, 280, 119, 119);
  if(playRide == true) {
    fill(226, 134, 145);
    ellipse(520, 280, 119, 119);
  }
  fill(249, 204, 103);
  textSize(64);
  text("P", 501, 305);
}
