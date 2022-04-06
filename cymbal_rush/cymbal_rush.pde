import themidibus.*; //Import the library
import java.util.*;

MidiBus myBus; // The MidiBus
color bgColor = color(0, 0, 0);
int numOfNotes = 75-55+1; // maxNote.pitch - minNote.pitch + 1
float barWidth;
int maxHue = 360;
int maxSB = 100; // saturation and brightness max value

ArrayList<PShape> shapes = new ArrayList<PShape>();

// Relative to cymbal rush
int minPitch = 55;
int maxPitch = 75; 

void setup() {
  fullScreen();
  barWidth = width / numOfNotes;
  
  background(bgColor);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "LKMK3 MIDI Out", "IAC_MIDI"); // Create a new MidiBus with my launch key midi controller as input
  colorMode(HSB, maxHue, maxSB, maxSB); // change color mode to HSB and set max values
    
  // create ArrayList with an invisible bar for each note between min and max note filling the whole screen
  for (int i = 0; i < numOfNotes; i++) {
    float hue = map(i, 0, numOfNotes, 0, maxHue);
    PShape shape = createShape(RECT, i * barWidth, 0, barWidth, height);
    shape.setFill(color(hue, maxSB, maxSB));
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

// Function called whenever a new note is played
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  int noteIndex = (int) map(pitch, minPitch, maxPitch, 0, shapes.size() - 1);
  if (noteIndex >= shapes.size() || noteIndex < 0) return;
  PShape shape = shapes.get(noteIndex);
  
  shape.setVisible(velocity != 0);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  int noteIndex = (int) map(pitch, minPitch, maxPitch, 0, shapes.size() - 1);
  if (noteIndex >= shapes.size() || noteIndex < 0) return;
  PShape shape = shapes.get(noteIndex);
  
  shape.setVisible(velocity != 0);
}
