import themidibus.*;

MidiBus myBus; // The MidiBus
int maxHue = 360;
int maxSB = 100; // saturation and brightness max value
Boolean shouldDraw = false;
color dark = color(0);
color light = color(200);
color bgColor = dark;
color circleColor = light;
int previousPitch = 0;

void setup() {
  fullScreen();
  setupAudio();
  background(bgColor);
}

void setupAudio() {
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "LKMK3 MIDI Out", "IAC_MIDI");
}

void draw() {
  background(bgColor);
  drawCircle(shouldDraw);
}

void drawCircle(Boolean shouldDraw) {
  if (shouldDraw) {
    int ellipseDiameter = height / 3;
    fill(circleColor);
    ellipse(width/2, height/2, ellipseDiameter, ellipseDiameter);
  }
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
  
  shouldDraw = true;
  
  //if (pitch == 49) {
  //  lightCircle();
  //}
  
  //if (pitch == 58) {
  //  darkCircle();
  //}
  
  if (pitch != previousPitch) {
    if (previousPitch != 0) 
      invertColors();
    previousPitch = pitch;
  }
}

void invertColors() {
  bgColor = (bgColor == dark) ? light : dark;
  circleColor = (bgColor == dark) ? light : dark;
}

void lightCircle() {
  bgColor = dark;
  circleColor = light;
}

void darkCircle() {
  bgColor = light;
  circleColor = dark;
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  shouldDraw = false;
}
