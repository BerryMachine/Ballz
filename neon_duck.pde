void setup() {
  size(500, 500);
  background(0);
  
  String[] n = loadStrings("data1.txt");

  String[] dimensions = n[0].split("\t");
  String[] position = n[1].split("\t");
  
  println(dimensions);
  println(position);
  
  fill(250, 250, 20);
  for (int row = 0; row < int(dimensions[0]); row++) {
    for (int col = 0; col < int(dimensions[1]); col++) {
      circle(int(position[0]) + 50*col, int(position[1]) + 50*row, 20);
    }
  }

}
