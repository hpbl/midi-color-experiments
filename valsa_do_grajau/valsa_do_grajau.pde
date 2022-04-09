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
boolean shouldDrawShape = true;


////// Color variables //////
color bgColor = color(0);
color shapeColor = color(255);
int maxHue = 360;
int minHue = 0;
int maxSaturationAndBrightness = 100;

////// Motion variables //////
float angle = 0;
float circularMovementRadius;
float defaultCircularMovementRadius;
float motionOffset = 10;

// false for direction to axis
// true for out axis
boolean danceDirection = false;

////// Audio variables //////
MidiBus myBus;
int minPitch = 36;
int maxPitch = 84;
boolean hasPlayedFirstNote = false;
int noteCount = 0;
int noteToSwitchDirection = 8;


////// SETUP //////
void setup() {
  // visual setup
  fullScreen();
  background(bgColor);
  colorMode(HSB, maxHue, maxSaturationAndBrightness, maxSaturationAndBrightness);
  
  // motion setup
  circularMovementRadius = height * 0.2;
  defaultCircularMovementRadius = circularMovementRadius
  motionOffset = circularMovementRadius * 0.5;
  
  setupAudio();
}

void setupAudio() {
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "LKMK3 MIDI Out", "");
}


////// DRAWING //////
void draw() {
  noStroke();
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
    int ellipseDiameter = height / 10;
    int offset = ellipseDiameter + 20;
    
    PVector position = positionForShape();
      
    fill(shapeColor);
    ellipse(position.x, position.y, ellipseDiameter, ellipseDiameter);
    ellipse(position.x + offset, position.y, ellipseDiameter, ellipseDiameter);
  }
}

PVector positionForShape() {
  // TODO: Add variation to circularMovementRadius se baixo ou acorde
  // Circular motion
  angle = angle + 0.03;
  
  motionOffset = movementOffsetForNote(danceDirection);
  float x = (width / 2) + (cos(angle) * (circularMovementRadius + motionOffset));
  float y = (height / 2) + (sin(angle) * (circularMovementRadius + motionOffset));
  
  return new PVector(x, y);
}


////// NOTE TO DRAWING MAPPING //////
color colorForNote(int channel, int pitch, int velocity) {
  float noteHue = map(pitch, minPitch, maxPitch, minHue, maxHue);
  return color(noteHue, maxSaturationAndBrightness, maxSaturationAndBrightness);
}

float movementOffsetForNote(int channel, int pitch, int velocity) {
  if (pitch >= MIN_BASS_PITCH) {
    return circularMovementRadius * 1.5;
  } else {
    return circularMovementRadius * 0.5;
  }
}

float movementOffsetForNote(boolean danceDirection) {
  if (danceDirection) {
    return circularMovementRadius * 1.5;
  } else {
    return circularMovementRadius * 0.5;
  }
}

////// AUDIO //////
void noteOn(int channel, int pitch, int velocity) {
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  hasPlayedFirstNote = true;
  noteCount += 1;
  
  if (noteCount % noteToSwitchDirection == 0) {
    danceDirection = !danceDirection;
    
  }
  
  
  // Perform mapings from note parameters to visual components (e.g. color, shape, size, ...)
  shapeColor = colorForNote(channel, pitch, velocity);
  motionOffset = movementOffsetForNote(channel, pitch, velocity);
  
  shouldDrawShape = true;
  //loop();
}

void noteOff(int channel, int pitch, int velocity) {
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  //shouldDrawShape = false;
  //noLoop();
}
