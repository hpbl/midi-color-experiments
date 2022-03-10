import themidibus.*; //Import the library
import java.util.*;


MidiBus myBus; // The MidiBus
color bgColor = color(0, 0, 0);
int numOfNotes = 75-55+1; // minNote.pitch - maxNote.pitch + 1
float barWidth;
int sb = 100;

List<Note> notesToBeDrawn = new ArrayList<Note>();
ArrayList<PShape> shapes = new ArrayList<PShape>();

// min note
//Channel:9
//Pitch:55
//Velocity:0

// max note
//Channel:9
//Pitch:75
//Velocity:0

void setup() {
  fullScreen();
  barWidth = width / numOfNotes;
  
  background(bgColor);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "LKMK3 MIDI Out", "IAC_MIDI"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  background(0);
  colorMode(HSB, 360, sb, sb);
    
  for (int i = 0; i < numOfNotes; i++) {
    float hue = map(i, 0, numOfNotes, 0, 360);
    PShape shape = createShape(RECT, i * barWidth, 0, barWidth, height);
    shape.setFill(color(hue, sb, sb));
    shape.setVisible(false);
    shapes.add(shape);
  }
}

void draw() {
   background(bgColor);
   for (PShape p : shapes) {
    shape(p);
  }
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  //println();
  //println("Note On:");
  //println("--------");
  //println("Channel:"+channel);
  //println("Pitch:"+pitch);
  //println("Velocity:"+velocity);
  int noteIndex = (int) map(pitch, 55, 75, 0, shapes.size() - 1);

  PShape shape = shapes.get(noteIndex);
  if (velocity == 0) {
    shape.setVisible(false);
    println(shape.isVisible());
    
  } else {
    shape.setVisible(true);
  }
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}
