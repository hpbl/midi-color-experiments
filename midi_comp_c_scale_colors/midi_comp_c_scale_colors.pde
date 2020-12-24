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


void setup() {
  size(1600, 250);
  background(bgColor);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "IAC_MIDI", "IAC_MIDI"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  int channel = 0;
  int pitch = 64;
  int velocity = randomVelocity();

  background(bgColor);
  myBus.sendNoteOn(channel, notes[currNoteIndex], velocity); // Send a Midi noteOn
  delay(int(random(300, 900)));
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  setNextNoteIndex();
}

void setNextNoteIndex() {
  currNoteIndex = int(random(0, notes.length));
}

void noteOn(int channel, int pitch, int velocity) {
  bgColor = color(
    pitchToColorFactor(pitch),
    velocityToColorFactor(velocity),
    indexToColorFactor()
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
