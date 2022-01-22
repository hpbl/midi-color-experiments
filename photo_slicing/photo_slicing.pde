// Remember to add a background image at the same
// folder of this script

import themidibus.*;

// 
// Lifecycle
// 
void setup() {
  // The background image must be the same size as the screen
  bg = loadImage("background.JPG");
  size(600, 800);

  createAllShapes();

  setupAudio();
}

void draw() {
  background(bg);


  // calculating squares
  int index = (int) random(shapes.size());
  addOrRemoveRandomShape(index);

  // audio
  int channel = 0;
  int velocity = randomVelocity();
  Note note = new Note(channel, index, velocity);
  myBus.sendNoteOn(note); // Send a Midi noteOn

	// drawing squares
  for (PShape p : shapes) {
  	p.setFill(shapeColor);
  	p.setStroke(shapeColor);
  	shape(p);
  }

  // stopping note
	delay(int(random(100, 900)));
  myBus.sendNoteOff(note); // Send a Midi nodeOff
}


// 
// Audio stuff
// 
MidiBus myBus;
int minVelocity = 50;
int maxVelocity = 128;

void setupAudio() {
	MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "IAC_MIDI", "IAC_MIDI");
}

int randomVelocity() {
  return int(random(minVelocity, maxVelocity));
}


// 
// Visual stuff
// 
PImage bg;
ArrayList<PShape> shapes = new ArrayList<PShape>();
ArrayList<PVector> vectors = new ArrayList<PVector>();
color shapeColor = color(0, 0, 0);
int shapeWidth = 60;
int shapeHeight = 80;

void createAllShapes() {
	int columns = width / shapeWidth;
	int rows = height / shapeHeight;

	int currX, currY = 0;
	for (int y = 0; y < rows; ++y) {
		currY = y * shapeHeight;
		for (int x = 0; x < columns; ++x) {
			currX = x * shapeWidth;
			shapes.add(createShape(RECT, currX, currY, shapeWidth, shapeHeight));
		}
	}
}

void addOrRemoveRandomShape(int shapeIndex) {
	PShape shape = shapes.get(shapeIndex);
	shape.setVisible(!shape.isVisible());
}
