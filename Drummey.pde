import oscP5.*;
import netP5.*;
import controlP5.*;

OscP5 OP5;
ControlP5 CP5;
NetAddress netAdd;

// VERSION NUMBER
String version = "2022";
// MODE SELECT
int switchMode = 2; // 0=Fusion 1= Rock 2=Jazz
// PLAY STATUS
boolean playBass = false;
boolean playSnare = false;
boolean playTomTom1 = false;
boolean playTomTom2 = false;
boolean playHiHat = false;
boolean playRide = false;

float volume;
int threshold;
int attack;
int release;

void setup() {
  surface.setTitle("Drummey • " + "Version " + version);
  size(900, 600);
  frameRate(60);
  noStroke();
  
  // INITIALIZE OSC, CONTROLS & NETWORK
  CP5 = new ControlP5(this);
  OP5 = new OscP5(this,4560);
  netAdd = new NetAddress("127.0.0.1",4560);
  
  // SELECT MODE BUTTONS 
  CP5 = new ControlP5(this);
  CP5.addButton("Jazz")
     .setValue(2)
     .setPosition(49,101)
     .setSize(79,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
   CP5.addButton("Rock")
     .setValue(1)
     .setPosition(49,79)
     .setSize(79,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  CP5.addButton("Fusion")
     .setValue(0)
     .setPosition(49,57)
     .setSize(79,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  CP5.addKnob("Volume")
     .setValue(50)
     .setPosition(794, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b)
     .setNumberOfTickMarks(20)
     .setTickMarkLength(5)
     .snapToTickMarks(true)
     .showTickMarks(false); 
     ;
  /*
  CP5.addButton("Start")
     .setValue(1)
     .setPosition(49,130)
     .setSize(79,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  CP5.addButton("Stop")
     .setValue(0)
     .setPosition(49,152)
     .setSize(79,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  CP5.addButton("Save")
     .setValue(2)
     .setPosition(49,174)
     .setSize(79,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  */
  CP5.addKnob("Threshold")
     .setRange(0,30)
     .setValue(0)
     // .setPosition(327, 482)
     .setPosition(360, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b);
     ;
  /*
  CP5.addKnob("Ratio") // RANGE SETTINGS CHECKEN
     .setRange(0,4)
     .setValue(0)
     .setPosition(392, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b)
     .setNumberOfTickMarks(4)
     .setTickMarkLength(1)
     .snapToTickMarks(true)
     ;
  */
  CP5.addKnob("Attack")
     .setRange(0,100)
     .setValue(0)
     // .setPosition(457, 482)
     .setPosition(425, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b);
     ;
  CP5.addKnob("Release")
     .setRange(0,500)
     .setValue(0)
     // .setPosition(522, 482)
     .setPosition(490, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b);
     ;
}


void draw() {
  background(43, 43, 43);
  PFont fontBold = loadFont("Calibri-Bold.vlw");
  textFont(fontBold);
  
  fill(224, 224, 224);
  textSize(14);
  text("Select Drums", 50, 50);
  
  // CHECK MODE
  if(switchMode == 0) drawFusion();
  if(switchMode == 1) drawRock();
  if(switchMode == 2) drawJazz();
  
  fill(66, 66, 66);
  // rect((width/2)-130, 477, 260, 73, 10);
  rect((width/2)-100, 477, 201, 73, 10);
  
  fill(66, 66, 66);
  rect(789, 477, 60, 73, 10);
}


public void Jazz(int theValue) {
  println("Mode: " + theValue + " (Jazz)");
  switchMode = theValue;
}


public void Rock(int theValue) {
  println("Mode: " + theValue + " (Rock)");
  switchMode = theValue;
}


public void Fusion(int theValue) {
  println("Mode: " + theValue + " (Fusion)");
  switchMode = theValue;
}

public void Volume(float theValue) {
  println("Volume: " + theValue);
  /*
  OscMessage volume = new OscMessage("/volume");
  volume.add(theValue);
  OP5.send(volume, netAdd);
  */
  volume = theValue/100;
  println("Volume: " + volume);
}


public void Threshold(int theValue) {
  println("Threshold: " + theValue);
  threshold = theValue;
}


public void Attack(int theValue) {
  println("Attack: " + theValue);
  attack = theValue/100;
}


public void Releae(int theValue) {
  println("Release: " + theValue);
  release = theValue;
}


void keyPressed() {
  OscMessage drum = new OscMessage("/jazzDrums");
  OscMessage setT = new OscMessage("/setT");
  OscMessage setA = new OscMessage("/setA");
  if (key == ' ') {
    playBass = true;
    drum.add(volume);
    // setT.add(threshold);
    // setA.add(attack);
  } else if(key != ' ') {
      drum.add(0);
    }
  if (key == 's' || key == 'S') {
    playSnare = true;
    drum.add(volume);
  } else if(key != 's' || key != 'S') {
      drum.add(0);
    }
  if (key == 'd' || key == 'D') {
    playTomTom1 = true;
    drum.add(volume);
  } else if(key != 'd' || key != 'D') {
      drum.add(0);
    }
  if (key == 'j' || key == 'J') {
    playTomTom2 = true;
    drum.add(volume);
  } else if(key != 'j' || key != 'J') {
      drum.add(0);
    }
  if (key == 'k' || key == 'K') {
    playRide = true;
    drum.add(volume);
  } else if(key != 'k' || key != 'K') {
      drum.add(0);
    }
  if (key == 'a' || key == 'A') {
    playHiHat = true;
    drum.add(volume);
  } else if(key != 'a' || key != 'A') {
      drum.add(0);
    }
  OP5.send(drum, netAdd);
  // OP5.send(setT, netAdd);
  // OP5.send(setA, netAdd);
}


void keyReleased() {
  if (key == ' ') playBass = false;
  if (key == 's' || key == 'S') playSnare = false;
  if (key == 'd' || key == 'D') playTomTom1 = false;
  if (key == 'j' || key == 'J') playTomTom2 = false;
  if (key == 'k' || key == 'K') playRide = false;
  if (key == 'a' || key == 'A') playHiHat = false;
}


void drawJazz() {
  fill(224, 224, 224);
  textSize(24);
  String activeDrums = "Jazz Drums";
  text(activeDrums, (width/2-(textWidth(activeDrums)/2)), 55);
  // _________________________________________________________
  // BASS
  fill(204, 204, 204);
  rect((width/2)-127.5, 150, 255, 8, 30, 30, 0, 0);
  fill(104, 77, 62);
  rect((width/2)-127.5, 158, 255, 100);
  fill(204, 204, 204);
  rect((width/2)-127.5, 258, 255, 8, 0, 0, 30, 30);
  fill(204, 204, 204);
  ellipse((width/2)-1, 208, 26, 26);
  //
  pushMatrix();
  translate((width/2)-1, 204);
  rotate(radians(15));
  fill(204, 204, 204);
  rect(0, 0, 150, 8);
  popMatrix();
  //
  pushMatrix();
  translate((width/2)-1, 211);
  rotate(radians(165));
  fill(204, 204, 204);
  rect(0, 0, 150, 8);
  popMatrix();
  //
  fill(91, 91, 91);
  rect((width/2)-25, 270, 50, 75, 7, 7, 0, 0);
  fill(124, 124, 124);
  rect((width/2)-25, 345, 50, 25, 0, 0, 7, 7);
  if(playBass == true) {
    fill(242, 51, 88);
    rect((width/2)-25, 270, 50, 75, 7, 7, 0, 0);
  }
  fill(198, 198, 198);
  textSize(15);
  String keyBass = "SPACE";
  text(keyBass, (width/2-(textWidth(keyBass)/2)), 315);
  // _________________________________________________________
  // TOMTOM 1
  fill(204, 204, 204);
  ellipse(350, 237, 120, 120);
  fill(199, 178, 153);
  ellipse(350, 237, 104, 104);
  if(playTomTom1 == true) {
    fill(242, 51, 88);
    ellipse(350, 237, 104, 104);
  }
  fill(237, 221, 206);
  textSize(90);
  text("D", 323, 266); // W --> D
  // _________________________________________________________
  // TOMTOM 2
  fill(204, 204, 204);
  ellipse(553, 237, 130, 130);
  fill(199, 178, 153);
  ellipse(553, 237, 114, 114);
  if(playTomTom2 == true) {
    fill(242, 51, 88);
    ellipse(553, 237, 114, 114);
  }
  fill(237, 221, 206);
  textSize(110);
  text("J", 533, 272); // Ä --> J
  // _________________________________________________________
  // RIDE
  fill(226, 178, 59);
  ellipse(650, 274, 135, 135);
  fill(206, 162, 40);
  ellipse(650, 274, 119, 119);
  if(playRide == true) {
    fill(242, 51, 88);
    ellipse(650, 274, 119, 119);
  }
  fill(249, 204, 103);
  textSize(110);
  text("K", 620, 310); // P --> K
  // _________________________________________________________
  // SNARE
  fill(204, 204, 204);
  ellipse(317, 368, 140, 140);
  fill(199, 178, 153);
  ellipse(317, 368, 124, 124);
  if(playSnare == true) {
    fill(242, 51, 88);
    ellipse(317, 368, 124, 124);
  }
  fill(237, 221, 206);
  textSize(120);
  text("S", 289, 407); // A --> S
  // _________________________________________________________
  // HIHAT
  fill(226, 178, 59);
  ellipse(233, 300, 135, 135);
  fill(206, 162, 40);
  ellipse(233, 300, 119, 119);
  if(playHiHat == true) {
    fill(242, 51, 88);
    ellipse(233, 300, 119, 119);
  }
  fill(249, 204, 103);
  textSize(110);
  text("A", 200, 332); // D --> A
}


void drawRock() {
  fill(224, 224, 224);
  textSize(24);
  String activeDrums = "Rock Drums";
  text(activeDrums, (width/2-(textWidth(activeDrums)/2)), 55);
}


void drawFusion() {
  fill(224, 224, 224);
  textSize(24);
  String activeDrums = "Fusion Drums";
  text(activeDrums, (width/2-(textWidth(activeDrums)/2)), 55);
}
