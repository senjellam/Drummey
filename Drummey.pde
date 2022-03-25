import oscP5.*;
import netP5.*;
import controlP5.*;
import java.text.SimpleDateFormat;
import java.util.Date;

OscP5 OP5;
ControlP5 CP5;
NetAddress netAdd;

// ==========================================================
// VERSION NUMBER
String version = "2022";
// ==========================================================
// MODE SELECT
int switchMode = 0; // 0=Fusion 1= Rock 2=Jazz
// ==========================================================
// PLAY STATUS
boolean playBass = false;
boolean playSnare = false;
boolean playTomTom1 = false;
boolean playTomTom2 = false;
boolean playTomTom3 = false;
boolean playHiHat = false;
boolean playRide = false;
boolean playCrash = false;
// ==========================================================
// KNOB INPUTS
float volume;
float attack;
float release;
float sustain;
float rate;
// ==========================================================
// PROGRAM STATUS
boolean startCode = false;
// ==========================================================
// RECORDING STATUS
String recPath = "";
String savePath = "D:/Hochschule/05_Wintersemester_2021-2022/Abschlussprojekte/Drummey/Drummey/";
String fileName = "Drummey_Recording_";
boolean recStatus = false;
boolean recCode = false;
boolean showSave = false;
int saveCode = 0;


// ====================================================================================
// SETUP FUNCTION
void setup() {
  // ==========================================================
  // SET PROGRAM PARAMETERS
  surface.setTitle("Drummey • " + "Version " + version);
  size(900, 600);
  frameRate(60);
  noStroke();
  // ==========================================================
  // INITIALIZE OSC, CONTROLS & NETWORK
  CP5 = new ControlP5(this);
  OP5 = new OscP5(this,4560);
  netAdd = new NetAddress("127.0.0.1",4560);
  // ==========================================================
  // SELECT MODE BUTTONS 
  CP5.addButton("Jazz")
     .setValue(2)
     .setPosition(49,101)
     .setSize(89,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
   CP5.addButton("Rock")
     .setValue(1)
     .setPosition(49,79)
     .setSize(89,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  CP5.addButton("Fusion")
     .setValue(0)
     .setPosition(49,57)
     .setSize(89,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  // ==========================================================
  // RECORDING BUTTONS
  CP5.addButton("Start")
     .setValue(1)
     .setPosition(49,150)
     .setSize(89,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  CP5.addButton("Stop")
     .setValue(1)
     .setPosition(49,172)
     .setSize(89,20)
     .setColorBackground(#424242)
     .setColorForeground(#5b5959)
     .setColorActive(#cea228);
     ;
  // ==========================================================
  // SETTINGS KNOBS
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
  CP5.addKnob("Attack")
     .setRange(0,10)
     .setValue(0)
     .setPosition(327, 482) // position for 4 buttons
     // .setPosition(360, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b)
     .setNumberOfTickMarks(10)
     .setTickMarkLength(1)
     .snapToTickMarks(true)
     .showTickMarks(false);
     ;
  CP5.addKnob("Release")
     .setRange(0,10)
     .setValue(0)
     .setPosition(392, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b)
     .setNumberOfTickMarks(10)
     .setTickMarkLength(1)
     .snapToTickMarks(true)
     .showTickMarks(false);
     ;
  CP5.addKnob("Sustain")
     .setRange(0,10)
     .setValue(0)
     .setPosition(457, 482) //  position for 4 buttons
     // .setPosition(425, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b)
     .setNumberOfTickMarks(10)
     .setTickMarkLength(1)
     .snapToTickMarks(true)
     .showTickMarks(false);
     ;
  CP5.addKnob("Rate")
     .setRange(0.6,1.4)
     .setValue(1)
     .setPosition(522, 482) // position for 4 buttons
     // .setPosition(490, 482)
     .setSize(50,50)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#e2b23b)
     .setNumberOfTickMarks(4)
     .setTickMarkLength(2)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setViewStyle(Knob.ELLIPSE);
     ;
  // ==========================================================
  // FX TOGGLES  
  CP5.addToggle("Distortion")
     .setPosition(59,444)
     .setSize(42,15)
     .setValue(0)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#cea228)
     ;
  CP5.addToggle("Reverb")
     .setPosition(59,479)
     .setSize(42,15)
     .setValue(0)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#cea228)
     ;
  CP5.addToggle("Wobble")
     .setPosition(59,514)
     .setSize(42,15)
     .setValue(0)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(#5b5959)
     .setColorForeground(#cea228)
     .setColorActive(#cea228)
     ;
  // ==========================================================
  // SETS KNOBS TO ZERO AT START
  if(startCode == false) {
    /*
    OscMessage setAttack = new OscMessage("/setAttack");
    attack = 0;
    setAttack.add(attack);
    OP5.send(setAttack, netAdd);
    
    OscMessage setRelease = new OscMessage("/setRelease");
    release = 0;
    setRelease.add(release);
    OP5.send(setRelease, netAdd);
    
    OscMessage setSustain = new OscMessage("/setSustain");
    sustain = 0;
    setSustain.add(sustain);
    OP5.send(setSustain, netAdd);
    */
    
    OscMessage setRate = new OscMessage("/setRate");
    rate = 1;
    setRate.add(rate);
    OP5.send(setRate, netAdd);
    
    startCode = true;
  }
}


// ====================================================================================
// DRAW FUNCTION
void draw() {
  // ==========================================================
  // SET PROGRAM PARAMETERS
  background(43, 43, 43);
  PFont fontBold = loadFont("Calibri-Bold.vlw");
  textFont(fontBold);
  // ==========================================================
  // BUTTON DESC
  fill(224, 224, 224);
  textSize(14);
  text("Select Drums", 50, 50);
  fill(224, 224, 224);
  textSize(14);
  text("Record Session", 50, 143);
  // ==========================================================
  // CHECK MODE
  if(switchMode == 0) drawFusion();
  if(switchMode == 1) drawRock();
  if(switchMode == 2) drawJazz();
  // ==========================================================
  // MENU FOR SETTINGS
  fill(66, 66, 66);
  rect((width/2)-130, 477, 260, 73, 10);
  //rect((width/2)-100, 477, 201, 73, 10);
  // ==========================================================
  // MENU FOR VOLUME
  fill(66, 66, 66);
  rect(789, 477, 60, 73, 10);
  // ==========================================================
  // MENU FOR FX
  fill(66, 66, 66);
  rect(50, 434, 60, 116, 10);
  // ==========================================================
  // RECORDING STATUS ICON
  if(recStatus == true) {
    fill(66, 66, 66);
    rect(799, 36, 50, 23, 10);
    fill(224, 224, 224);
    textSize(14);
    text("REC", 807, 52.5);
    fill(255, 0, 0);
    ellipse(837, 48, 10, 10);
  }
  // DRAW SAVE PATH
  if(showSave == true) {
    // drawSave(recPath);
  }
}


// ====================================================================================
// JAZZ BUTTON FUNCTION
public void Jazz(int theValue) {
  println("Mode: " + theValue + " (Jazz)");
  switchMode = theValue;
}
// ROCK BUTTON FUNCTION
public void Rock(int theValue) {
  println("Mode: " + theValue + " (Rock)");
  switchMode = theValue;
}
// FUSION BUTTON FUNCTION
public void Fusion(int theValue) {
  println("Mode: " + theValue + " (Fusion)");
  switchMode = theValue;
}
// START BUTTON FUNCTION
public void Start(int theValue) {
  if(recCode == true) {
    OscMessage setStart = new OscMessage("/setStart");
    if(theValue == 1) {
      setStart.add(theValue);
      theValue = 0;
      recStatus = true;
      saveCode = 1;
    } else {
        setStart.add(0);
    }
    OP5.send(setStart, netAdd);
  } else {
       recCode = true;
  }
}
// STOP BUTTON FUNCTION
public void Stop(int theValue) {
  if(recCode == true) {
    OscMessage setStop = new OscMessage("/setStop");
    if(theValue == 1) {
      setStop.add(theValue);
      theValue = 0;
      recStatus = false;
      // SETS RECORDING PATH
      OscMessage setPath = new OscMessage("/setPath");
      SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy_HH-mm-ss");
      Date currentTime = new Date();
      System.out.println(formatter.format(currentTime));
      // recPath = "D:/Hochschule/05_Wintersemester_2021-2022/Abschlussprojekte/Drummey/Drummey/Drummey_Recording_"+ formatter.format(currentTime) +".wav";
      recPath = savePath + fileName + formatter.format(currentTime) + ".wav";
      setPath.add(recPath);
      OP5.send(setPath, netAdd);
      // DRAW SAVE PATH
      if(saveCode == 1) showSave = true;
    } else {
        setStop.add(0);
    }
    OP5.send(setStop, netAdd);
  } else {
       recCode = true;
  }
}


// ====================================================================================
// VOLUME KNOB FUNCTION
public void Volume(float theValue) {
  println("Processing Volume: " + theValue);
  volume = theValue/100;
  println("Sonic Pi Volume: " + volume);
}
// ATTACK KNOB FUNCTION
public void Attack(float theValue) {
  OscMessage setAttack = new OscMessage("/setAttack");
  println("Processing Attack: " + theValue);
  attack = theValue/50;
  attack = Math.round(attack * 100) / 100.0;
  println("Sonic Pi Attack: " + attack);
  setAttack.add(attack);
  OP5.send(setAttack, netAdd);
}
// RELEASE KNOB FUNCTION
public void Release(float theValue) {
  OscMessage setRelease = new OscMessage("/setRelease");
  println("Processing Release: " + theValue);
  release = 1 - theValue/10;
  release = Math.round(release * 100) / 100.0;
  println("Sonic Pi Release: " + release);
  setRelease.add(release);
  OP5.send(setRelease, netAdd);
}
// SUBSTAIN KNOB FUNCTION
public void Sustain(float theValue) {
  OscMessage setSustain = new OscMessage("/setSustain");
  println("Processing Sustain: " + theValue);
  sustain = 1 - theValue/10;
  sustain = Math.round(sustain * 100) / 100.0;
  println("Sonic Pi Sustain: " + sustain);
  setSustain.add(sustain);
  OP5.send(setSustain, netAdd);
}
// RATE KNOB FUNCTION
public void Rate(float theValue) {
  OscMessage setRate = new OscMessage("/setRate");
  println("Processing Rate: " + theValue);
  rate = theValue;
  println("Sonic Pi Rate: " + rate);
  setRate.add(rate);
  OP5.send(setRate, netAdd);
}


// ====================================================================================
// KEYBOARD INPUT FUNCTION
void keyPressed() {
  // ==========================================================
  // KEYBINDS FOR FUSION DRUMS
  if(switchMode == 0) {
    OscMessage drumsFusion = new OscMessage("/drumsFusion");
    if (key == ' ') {
      playBass = true;
      drumsFusion.add(volume);
    } else if(key != ' ') {
        drumsFusion.add(0);
      }
    if (key == 's' || key == 'S') {
      playSnare = true;
      drumsFusion.add(volume);
    } else if(key != 's' || key != 'S') {
        drumsFusion.add(0);
      }
    if (key == 'd' || key == 'D') {
      playTomTom1 = true;
      drumsFusion.add(volume);
    } else if(key != 'd' || key != 'D') {
        drumsFusion.add(0);
      }
    if (key == 'j' || key == 'J') {
      playTomTom2 = true;
      drumsFusion.add(volume);
    } else if(key != 'j' || key != 'J') {
        drumsFusion.add(0);
      }
    if (key == 'k' || key == 'K') {
      playRide = true;
      drumsFusion.add(volume);
    } else if(key != 'k' || key != 'K') {
        drumsFusion.add(0);
      }
    if (key == 'a' || key == 'A') {
      playHiHat = true;
      drumsFusion.add(volume);
    } else if(key != 'a' || key != 'A') {
        drumsFusion.add(0);
      }
    if (key == 'l' || key == 'L') {
      playTomTom3 = true;
      drumsFusion.add(volume);
    } else if(key != 'l' || key != 'L') {
        drumsFusion.add(0);
      }
    OP5.send(drumsFusion, netAdd);
  }
  // ==========================================================
  // KEYBINDS FOR ROCK DRUMS
  if(switchMode == 1) {
    OscMessage drumsRock = new OscMessage("/drumsRock");
    if (key == ' ') {
      playBass = true;
      drumsRock.add(volume);
    } else if(key != ' ') {
        drumsRock.add(0);
      }
    if (key == 's' || key == 'S') {
      playSnare = true;
      drumsRock.add(volume);
    } else if(key != 's' || key != 'S') {
        drumsRock.add(0);
      }
    if (key == 'd' || key == 'D') {
      playTomTom1 = true;
      drumsRock.add(volume);
    } else if(key != 'd' || key != 'D') {
        drumsRock.add(0);
      }
    if (key == 'j' || key == 'J') {
      playTomTom2 = true;
      drumsRock.add(volume);
    } else if(key != 'j' || key != 'J') {
        drumsRock.add(0);
      }
    if (key == 'k' || key == 'K') {
      playRide = true;
      drumsRock.add(volume);
    } else if(key != 'k' || key != 'K') {
        drumsRock.add(0);
      }
    if (key == 'a' || key == 'A') {
      playHiHat = true;
      drumsRock.add(volume);
    } else if(key != 'a' || key != 'A') {
        drumsRock.add(0);
      }
    if (key == 'l' || key == 'L') {
      playTomTom3 = true;
      drumsRock.add(volume);
    } else if(key != 'l' || key != 'L') {
        drumsRock.add(0);
      }
    if (key == 'w' || key == 'W') {
      playCrash = true;
      drumsRock.add(volume);
    } else if(key != 'w' || key != 'W') {
        drumsRock.add(0);
      }
    OP5.send(drumsRock, netAdd);
  }
  // ==========================================================
  // KEYBINDS FOR JAZZ DRUMS
  if(switchMode == 2) {
    OscMessage drumsJazz = new OscMessage("/drumsJazz");
    if (key == ' ') {
      playBass = true;
      drumsJazz.add(volume);
    } else if(key != ' ') {
        drumsJazz.add(0);
      }
    if (key == 's' || key == 'S') {
      playSnare = true;
      drumsJazz.add(volume);
    } else if(key != 's' || key != 'S') {
        drumsJazz.add(0);
      }
    if (key == 'd' || key == 'D') {
      playTomTom1 = true;
      drumsJazz.add(volume);
    } else if(key != 'd' || key != 'D') {
        drumsJazz.add(0);
      }
    if (key == 'j' || key == 'J') {
      playTomTom2 = true;
      drumsJazz.add(volume);
    } else if(key != 'j' || key != 'J') {
        drumsJazz.add(0);
      }
    if (key == 'k' || key == 'K') {
      playRide = true;
      drumsJazz.add(volume);
    } else if(key != 'k' || key != 'K') {
        drumsJazz.add(0);
      }
    if (key == 'a' || key == 'A') {
      playHiHat = true;
      drumsJazz.add(volume);
    } else if(key != 'a' || key != 'A') {
        drumsJazz.add(0);
      }
    OP5.send(drumsJazz, netAdd);
  }
}


// ====================================================================================
// KEYBOARD INPUT FUNCTION
void keyReleased() {
  if (key == ' ') playBass = false;
  if (key == 's' || key == 'S') playSnare = false;
  if (key == 'd' || key == 'D') playTomTom1 = false;
  if (key == 'j' || key == 'J') playTomTom2 = false;
  if (key == 'k' || key == 'K') playRide = false;
  if (key == 'a' || key == 'A') playHiHat = false;
  if (key == 'l' || key == 'L') playTomTom3 = false;
  if (key == 'w' || key == 'W') playCrash = false;
}


// ====================================================================================
// DISPLAY SAVE SUCCESS
void drawSave(String path) {
  fill(66, 66, 66);
  rect(50, 565, 800, 20, 5);
  fill(224, 224, 224);
  textSize(12);
  text(path, 146, 579);
  
  fill(102,205,0);
  textSize(12);
  String sessionSaved = "Session Saved In:";
  text(sessionSaved, 56, 579);
}


// ====================================================================================
// DISPLAY JAZZ DRUMS FUNCTION
void drawJazz() {
  fill(224, 224, 224);
  textSize(24);
  String activeDrums = "Jazz Drums";
  text(activeDrums, (width/2-(textWidth(activeDrums)/2)), 55);
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
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


// ====================================================================================
// DISPLAY ROCK DRUMS FUNCTION
void drawRock() {
  fill(224, 224, 224);
  textSize(24);
  String activeDrums = "Rock Drums";
  text(activeDrums, (width/2-(textWidth(activeDrums)/2)), 55);
  // ==========================================================
  // BASS
  fill(204, 204, 204);
  rect((width/2)-150, 150, 300, 8, 30, 30, 0, 0);
  fill(142, 32, 42);
  rect((width/2)-150, 158, 300, 100);
  fill(204, 204, 204);
  rect((width/2)-150, 258, 300, 8, 0, 0, 30, 30);
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
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
  // TOMTOM 3
  fill(204, 204, 204);
  ellipse(555, 367, 122, 122);
  fill(199, 178, 153);
  ellipse(555, 367, 106, 106);
  if(playTomTom3 == true) {
    fill(242, 51, 88);
    ellipse(555, 367, 106, 106);
  }
  fill(237, 221, 206);
  textSize(100);
  text("L", 534, 397);
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
  // CRASH
  fill(226, 178, 59);
  ellipse(292, 185, 115, 115);
  fill(206, 162, 40);
  ellipse(292, 185, 99, 99);
  if(playCrash == true) {
    fill(242, 51, 88);
    ellipse(292, 185, 99, 99);
  }
  fill(249, 204, 103);
  textSize(80);
  text("W", 255, 212); // D --> A
}


// ====================================================================================
// DISPLAY FUSION DRUMS FUNCTION
void drawFusion() {
  fill(224, 224, 224);
  textSize(24);
  String activeDrums = "Fusion Drums";
  text(activeDrums, (width/2-(textWidth(activeDrums)/2)), 55);
  // ==========================================================
  // BASS
  fill(204, 204, 204);
  rect((width/2)-140, 150, 280, 8, 30, 30, 0, 0);
  fill(99, 33, 244);
  rect((width/2)-140, 158, 280, 100);
  fill(204, 204, 204);
  rect((width/2)-140, 258, 280, 8, 0, 0, 30, 30);
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
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
  // TOMTOM 3
  fill(204, 204, 204);
  ellipse(555, 367, 122, 122);
  fill(199, 178, 153);
  ellipse(555, 367, 106, 106);
  if(playTomTom3 == true) {
    fill(242, 51, 88);
    ellipse(555, 367, 106, 106);
  }
  fill(237, 221, 206);
  textSize(100);
  text("L", 534, 397);
  // ==========================================================
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
  // ==========================================================
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
  // ==========================================================
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
