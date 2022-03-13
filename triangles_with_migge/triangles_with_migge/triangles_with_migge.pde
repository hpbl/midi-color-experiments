import themidibus.*;

Boolean fullScreenTriangle = false;
Boolean shouldDraw = false;
int previousPitch = 0;
MidiBus myBus; // The MidiBus
color triangleColor = color(0, 0, 0);
int maxHue = 360;
int maxSB = 100; // saturation and brightness max value

void setup() {
  fullScreen();
  setupAudio();
  colorMode(HSB, maxHue, maxSB, maxSB); // change color mode to HSB and set max values
  background(0);
}

void setupAudio() {
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "LKMK3 MIDI Out", "IAC_MIDI");
}

void draw() {
  background(0);
  //drawTriangle(fullScreenTriangle);
  drawRandomTriangle(shouldDraw);
  noLoop();
}

void mouseClicked() {
  fullScreenTriangle = !fullScreenTriangle;
}

// Function called whenever a new note is played
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  //println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  //float noteHue = map(pitch, 36, 84, 0, maxHue); mapping all keys of the keyboard
  
  float noteHue = map(pitch % 12, 0, 11, 0, maxHue);
  float noteSaturation = map(velocity, 0, 130, maxSB*0.8, maxSB);
  triangleColor = color(noteHue, noteSaturation, noteSaturation);
  //fullScreenTriangle = !fullScreenTriangle;
  //shouldDraw = (pitch != previousPitch);
    shouldDraw = true;

  previousPitch = pitch;
  loop();
}

void drawTriangle(Boolean fullScreen) {
  fill(triangleColor);
  
  if (fullScreen) {
    triangle(0, height,width/2, 0, width, height);
  }
  else {
    float x1 = width/3;
    float y1 = (2*height)/3;
    float x2 = width/2;
    float y2 = height/3;
    float x3 = (2*width)/3;
    float y3 = (2*height)/3;
    triangle(x1, y1, x2, y2, x3, y3);
   }
}

void drawRandomTriangle(Boolean shouldDraw) {
  if (shouldDraw) {
    fill(triangleColor);
    float x1 = width/3;
    float y1 = (2*height)/3;
    float x2 = width/2;
    float y2 = height/3;
    float x3 = (2*width)/3;
    float y3 = (2*height)/3;
    pushMatrix();
    translate(random(-width/3, width/3), random(-height/3, height/3));
    triangle(x1, y1, x2, y2, x3, y3);
    popMatrix();
  }
}
