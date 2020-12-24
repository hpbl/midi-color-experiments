import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
color bgColor = color(0, 0, 0);
int currNoteIndex = 0;
int[] notes = {
         60, // C4
         62,
         64,
         65,
         67,
         69,
         71 // B4
};
int minNote = min(notes);
int maxNote = max(notes);
int minVelocity = 50;
int maxVelocity = 128;
int minColor = 0;
int maxColor = 255;
int currX = 0;
int elipseWidth = 50;
boolean goingForward = true;
color shapeColor = #762DE0;

void setup() {
  size(1250, 600);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "IAC_MIDI", "IAC_MIDI"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  
  noLoop();
}

void draw() {
  // Clears background
  //background(0);
  
  // Play note and schedule it's stop
  int pitch = notes[currNoteIndex];
  myBus.sendNoteOn(0, pitch, 90); // Send a Midi noteOn
  new StopNoteThread(notes[currNoteIndex]).start();
  
  // Draw shape
  color pitchColor = pitchToColorFactor(pitch);
  stroke(255, 255, 255);
  fill(pitchColor);
  shape(elipseForNote());
  
  // Get ready for next note
  setNextNoteIndex();
  noLoop();
}

void setNextNoteIndex() {
  if (goingForward && currNoteIndex < (notes.length - 1)) {
    currNoteIndex++;
    
  } else if (goingForward) {
    goingForward = false;
    currNoteIndex--;
    
  } else if (!goingForward && currNoteIndex >= 1) {
    currNoteIndex--;
    
  } else if (!goingForward) {
    goingForward = true;
    currNoteIndex++;
  } else {
    println("unexpected index: " + currNoteIndex);
    println("goingForward: " + goingForward);
  }
}

void noteOn(int channel, int pitch, int velocity) {
  bgColor = color(
    pitchToColorFactor(pitch),
    velocityToColorFactor(velocity),
    indexToColorFactor()
  );
}

void testSin() {
  for (int i = 0; i < 10; i++) {
    print(sin(i));
  }
}

PShape elipseForNote() {
  currX += elipseWidth / 1.5;
  
  return createShape(
    ELLIPSE,
    currX,
    map(currNoteIndex, 0, notes.length, height * 0.7, height * 0.3),
    elipseWidth,
    elipseWidth
  );
}

int randomVelocity() {
  return int(random(minVelocity, maxVelocity));
}

int indexToColorFactor() {
  return int(map(currNoteIndex, 0, notes.length, minColor, maxColor)); 
}

int pitchToColorFactor(int pitch) {
  return int(map(pitch, minNote, maxNote, minColor, maxColor));
}

int velocityToColorFactor(int velocity) {
  return int(map(velocity, minVelocity, maxVelocity, minColor, maxColor));
}
