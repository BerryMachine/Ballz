int radius = 30, padding = 50, from_top = 0, cols, rows;
int[][] parameters;
String[] row_of_parameters;
int[][] prev_row_coords;

void setup() {
  size(500, 500);
  background(0);
  
  String[] grid = loadStrings("grid data.txt");
  
  cols = int(grid[0]);
  rows = grid.length-1;
  
  parameters = new int[rows][4];
  row_of_parameters = new String[cols];
  prev_row_coords = new int[cols][2]
  
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
  //draws the circles
  for(int row = 0; row < rows; row++){
    
    fill(parameters[row][0], parameters[row][1], parameters[row][2]);
    
    for(int col = 0; col < cols; col++){
      circle(padding + col*(width-2*padding)/(cols-1), parameters[row][3], radius);
    }
  }
}
