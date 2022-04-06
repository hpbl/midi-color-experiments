////// MIDI VISUALIZATION TEMPLATE
////// 
////// This template has the setup code needed to draw a shape when a note is played.
////// It also varies the color of the shape according to the pitch of the note. 
////// Use this to bootstrap your experiments.
////// 
////// Author: Hilton Pintor (@hpbl)
////// 

import themidibus.*;

////// Drawing loop control variables ////// 
boolean shouldClearOnDraw = true;
Boolean shouldDrawShape = false;


////// Color variables //////
color bgColor = color(0);
color shapeColor = color(255);
int maxHue = 360;
int minHue = 0;
int maxSaturationAndBrightness = 100;


////// Audio variables //////
MidiBus myBus;
int minPitch = 36;
int maxPitch = 84;


////// SETUP //////
void setup() {
  // visual setup
  fullScreen();
  background(bgColor);
  colorMode(HSB, maxHue, maxSaturationAndBrightness, maxSaturationAndBrightness);
  
  setupAudio();
}

void setupAudio() {
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "LKMK3 MIDI Out", "IAC_MIDI");
}


////// DRAWING //////
void draw() {
  clearBackground(shouldClearOnDraw);
  drawShape(shouldDrawShape);
}

void clearBackground(boolean shouldClear) {
  if (shouldClear) {
    background(bgColor);
  }
}

void drawShape(Boolean shouldDraw) {
  if (shouldDraw) {
    int ellipseDiameter = height / 3;
    fill(shapeColor);
    ellipse(width/2, height/2, ellipseDiameter, ellipseDiameter);
  }
}

color colorForNote(int channel, int pitch, int velocity) {
  float noteHue = map(pitch, minPitch, maxPitch, minHue, maxHue);
  return color(noteHue, maxSaturationAndBrightness, maxSaturationAndBrightness);
}


////// AUDIO //////
void noteOn(int channel, int pitch, int velocity) {
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  // Perform mapings from note parameters to visual components (e.g. color, shape, size, ...)
  shapeColor = colorForNote(channel, pitch, velocity);
  
  shouldDrawShape = true;
}

void noteOff(int channel, int pitch, int velocity) {
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  shouldDrawShape = false;
}
