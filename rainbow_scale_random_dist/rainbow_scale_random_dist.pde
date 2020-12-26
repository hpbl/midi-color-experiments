import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
color bgColor = color(0, 0, 0);
int currNoteIndex = 0;
int minVelocity = 50;
int maxVelocity = 128;

Note[] notes = {
         new Note(60, #e6261f),// C4
         new Note(62, #eb7532),
         new Note(64, #f7d038),
         new Note(65, #a3e048),
         new Note(67, #49da9a),
         new Note(69, #34bbe6),
         new Note(71, #4355db), // B4
         new Note(72, #d23be7)
};

void setup() {
  size(1400, 400);
  background(bgColor);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "IAC_MIDI", "IAC_MIDI"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  //noLoop();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    redraw();
  }
}

void draw() {
  background(0);
  
  int channel = 0;
  int pitch = notes[currNoteIndex].pitch;
  int velocity = randomVelocity();
  
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  //delay(int(random(300, 900))); // how long the note will be held
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  
  // Increase note count
  notes[currNoteIndex].timesPlayed += 1;
  
  // Increase note bar width
  float accumWidthBeforeNote = 0;
  for (int i = 0; i < notes.length; i++) {
    drawGrowingFromCenter(i, accumWidthBeforeNote);
    accumWidthBeforeNote += notes[i].width();
  }
  
  // Ready next note to be played
  setNextNoteIndex();
}

void drawShape(int noteIndex) { 
  float x = map(noteIndex, 0, notes.length, 0, width);
  float y = 0;
  Note note = notes[noteIndex];
  float noteWidth = note.timesPlayed * 20;
  
  fill(note.noteColor);
  rect(x, y, noteWidth, height);
}


float leftMarginFactor = 0.3;

void drawGrowingFromCenter(int noteIndex, float accumWidthBeforeNote) {
  Note note = notes[noteIndex];
  float x = x(accumWidthBeforeNote);
  float y = 0;
  
  fill(note.noteColor);
  stroke(note.noteColor);
  rect(x, y, note.width(), height);
}

float xFirstNote() {
  float groupWidth = 0;
  for (int i = 0; i < notes.length; i++) {
    groupWidth += notes[i].width();
  }
 
  return (width / 2) - (groupWidth / 2);
}

float x(float accumWidthBefore) {
  return xFirstNote() + accumWidthBefore;
}

void setNextNoteIndex() {
  currNoteIndex = int(random(0, notes.length));// (currNoteIndex + 1) % notes.length; //
}

int randomVelocity() {
  return int(random(minVelocity, maxVelocity));
}
