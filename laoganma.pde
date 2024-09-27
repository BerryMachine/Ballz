int radius = 30, padding = 50, from_top = 0, cols, rows;
int[][] parameters;
String[] row_of_parameters;
int[][] prev_row_coords, curr_row_coords;

void setup() {
  size(500, 500);
  background(0);
  noLoop();         // no animation 
  
  String[] grid = loadStrings("grid data.txt");
  
  cols = int(grid[0]);
  rows = grid.length-1;
  
  parameters = new int[rows][4];
  row_of_parameters = new String[cols];
  prev_row_coords = new int[cols][2];
  curr_row_coords = new int[cols][2];
  
  //translate the grid into the 2D array "parameters" - each row is in the form of {R, G, B, distance from top}
  for(int row = 1; row < rows+1; row++){
    row_of_parameters = grid[row].split("\t");
    from_top += int(row_of_parameters[3]);
    for(int col = 0; col < 3; col++){
      parameters[row-1][col] = int(row_of_parameters[col]);
      parameters[row-1][3] = from_top;
    }
  }
}

void draw() {
  // white lines
  stroke(255);
  
  // from top to bottom
  for(int row = 0; row < rows; row++){
    // extract y-coordinate of row
    int y = parameters[row][3];
    
    // extract color of ball
    fill(parameters[row][0], parameters[row][1], parameters[row][2]);
    
    // from left to right
    for(int col = 0; col < cols; col++){
      // calculate x coordinate of ball in row
      int x = padding + col*(width - 2*padding) / (cols-1);
      //println(y);
      
      if (row == 0) { // when prev_row_coords is empty
        prev_row_coords[col][0] = x;
        prev_row_coords[col][1] = y;
      } else { // when prev_row_coords is not empty
        curr_row_coords[col][0] = x;
        curr_row_coords[col][1] = y;
      
        // draw line
        for (int[] prev_row : prev_row_coords) {
          line(prev_row[0], prev_row[1], x, y);
        }
      
        // copy without reference (prev_row_coords = curr_row_coords)
        // stupid arrayCopy() doesn't work for 2d arrays and I wasted 2 hours figuring out why
        // needed to "deep copy"
        if (col == cols-1) {
          for (int copy = 0;  copy < cols; copy++) {
            arrayCopy(curr_row_coords[copy], prev_row_coords[copy]);
          }
        }
        
      }
      
      // draw circle
      circle(x, y, radius);
      
    }
  }
}