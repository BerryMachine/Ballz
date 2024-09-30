int radius = 15;
//padding on each side
int padding = 50;
//width of screen
int Width = 500;

//the imported data from the text file
String[] grid;

int cols, rows, spacing;

PVector[] balls, iballs, colors;
String[] parameters;
int from_top = 0;

boolean selected = false;
int rowSelected;
PVector mouseWhenSelected;

void setup() {
  size(500, 500);
  stroke(255);
  
  String[] grid = loadStrings("grid data.txt");

  //setting dimensions for the drawn circles
  cols = int(grid[0]);
  rows = grid.length-1;
  
  //spacing between adjacent circles
  spacing = (Width-2*padding)/(cols-1);
  
  //this contains the dimensions for the leftmost circle on each row
  balls = new PVector[rows];
  
  colors = new PVector[rows];
  parameters = new String[cols];

  for(int row = 1; row < rows+1; row++){
    parameters = grid[row].split("\t");
    from_top += int(parameters[3]);
    for(int col = 0; col < 3; col++){
      colors[row-1] = new PVector(int(parameters[0]), int(parameters[1]), int(parameters[2]));
      balls[row-1] = new PVector(padding, from_top);
    }
  }
  
  //iballs provides the initial positions of the leftmost balls when the mouse is clicked
  iballs = new PVector[balls.length];
}


void draw(){
  if(selected){
    balls[rowSelected] = new PVector(mouseX - mouseWhenSelected.x + iballs[rowSelected].x, mouseY - mouseWhenSelected.y + iballs[rowSelected].y);
  }
  drawCircles();
  drawLines();
}

void mousePressed(){
  for(int row = 0; row < rows; row++){
    PVector b = balls[row];
    for(int col = 0; col < cols; col++){
      if(dist(b.x + spacing*col, b.y, mouseX, mouseY) < radius){
        selected = true;
        rowSelected = row;
        
        //provides the initial positions of the mouse when the mouse is clicked
        mouseWhenSelected = new PVector(mouseX, mouseY);
        arrayCopy(balls, iballs);
      }
    }
  }
}

void mouseReleased() {
  selected = false;
}

void drawCircles(){
  background(0);
  for(int row = 0; row < rows; row++){
    fill(colors[row].x, colors[row].y, colors[row].z);
    for(int col = 0; col < cols; col++){
      circle(balls[row].x + spacing*col, balls[row].y, radius*2);
    }
  }
}

void drawLines(){
  for(int row = 0; row < rows-1; row++){
    for(int col1 = 0; col1 < cols; col1++){
      for(int col2 = 0; col2 < cols; col2++){
        line(balls[row].x + spacing*col1, balls[row].y, balls[row+1].x + spacing*col2, balls[row+1].y);
      }
    }
  }
}
