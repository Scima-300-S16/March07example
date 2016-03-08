//hi i'm on branch sararas <3
Table table;

void setup() { 
  size(1300, 700);
  background(0);
  // the file must be in the sketch's data folder
  // the argument "header" tells loadTable() to organize the file
  // columns according to the header line (the first line)
  table = loadTable("myfile.csv", "header"); 

  // How many rows did we read?
  int tableRowCount = table.getRowCount();
  int tableColumnCount = table.getColumnCount();

  // Print these numbers to check:
  println("Total rows in table = " + tableRowCount); 

  //getting number of rows and columns to space out data properly
  int noOfRowsandColumns = int(sqrt(tableRowCount));

  //dividing width by that number
  float w = (width)/noOfRowsandColumns;
  float h = (height)/noOfRowsandColumns;

  println("w: ", w);
  println("h: ", h);

  //establishing x and y values
  float x = 0;
  float y = 0;


  for (TableRow row : table.rows()) {

    int day = row.getInt("DD"); // the day
    int direction = row.getInt("WDIR"); // the wind direction
    float speed = row.getFloat("WSPD"); // the wind speed

    // the wind direction will indicate the rotation of the line
    // no sense in going more than 45 degrees as we can't tell the 
    // difference 
    int dirtoY = int(map(direction, 0, 360, 0, -90));

    // the wind speed will change the color (monochrome)
    int speedtoAlpha = int(map(speed, 0, 15, 0, 255));

    int speedtoWeight = int(map(speed, 0, 15, 0, 8));

    // increment x
    x += w;

    //traveling along the x axis until hitting width and then 
    //increasing on y axis and resetting x to 0
    if (x > width) {
      x = 0;
      y+=h;
    }

    //label at top
    float newx = map(x, 0, 1000, 30, 970);
    float newy = map(y, 0, 1000, 30, 970);
    drawTable(newx, newy, w, h, day, speedtoAlpha, dirtoY, speedtoWeight);
  }

  fill(255, 120);
  rect(0, 0, 250, 20);
  fill(0);
  text("wind speed and wind direction over time", 5, 15);
}

//this is the function that takes all the values established above
void drawTable(float x, float y, float w, float h, int day, int speedtoAlpha, int dirtoY, int speedtoWeight) {

  //switch case is a conditional statement sort of like an if statement
  // here it is being used to change colors for each day
  // you can mess around with it or take it out

  switch (day) {
  case 31:
    stroke(255, 0, 0, speedtoAlpha);
    break;
  case 1:
    stroke(0, 255, 0, speedtoAlpha);
    break;
  case 2:
    stroke(0, 0, 255, speedtoAlpha);
    break;
  case 3:
    stroke(255, 0, 0, speedtoAlpha);
    break;
  case 4:
    stroke(0, 255, 0, speedtoAlpha);
    break;
  case 5:
    stroke(0, 0, 255, speedtoAlpha);
    break;
  case 6:
    stroke(255, 0, 0, speedtoAlpha);
    break;
  case 7:
    stroke(0, 255, 0, speedtoAlpha);
    break;
  }

  // this is where the lines are getting drawn
  strokeWeight(speedtoWeight);
  ellipse(x, y, x+w, y+ dirtoY); 
  ellipse(x, y+h/3, x+w, y+h/3+ dirtoY); 
  ellipse(x, y+(h/3*2), x+w, y+(h/3*2)+dirtoY); 

  //println("dirtoCoord: ",dirtoY);
  //println("daytoColor: ", daytoColor);
}