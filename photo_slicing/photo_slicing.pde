PImage bg;
ArrayList<PShape> shapes = new ArrayList<PShape>();
ArrayList<PVector> vectors = new ArrayList<PVector>();
color shapeColor = color(0, 0, 0);
int shapeWidth = 64;
int shapeHeight = 64;

void setup() {
  // The background image must be the same size as the screen
  bg = loadImage("janjo.jpeg");
  size(640, 640);

  createAllShapes();
}

void draw() {
  background(bg);

  addOrRemoveRandomShape();

  for (PShape p : shapes) {
  	p.setFill(shapeColor);
  	p.setStroke(shapeColor);
  	shape(p);
  }
}

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

void addOrRemoveRandomShape() {
	int index = (int) random(shapes.size());

	PShape shape = shapes.get(index);
	shape.setVisible(!shape.isVisible());
}
