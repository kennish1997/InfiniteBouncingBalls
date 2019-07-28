/** ********************
    CISC 1600
    Project 2
    Kenny Shi and Komi Wu
*/
/* ********** ********** ********** Variables ********** ********** ********** */
int rad=200;//radius of centered ball
ArrayList balls;
int num=0;//sets the number of balls to 0
PFont largeFont;
PFont smallFont;
String state= "start";
/* ********** ********** **********  Setup ********** ********** **********  */
void setup(){
  frameRate(20);
  size(700,700); // Set the screen size.
  balls= new ArrayList();
  smooth();
  //starts with 0 balls excluding the centered ball
  for (int i=0; i<num; i++){
    balls.add(new ball());
  }
  String[] fontType = PFont.list();   
  largeFont = createFont(fontType[0], 48);     // Would be used for title
  smallFont = createFont(fontType[0], 25);  // Would be used for instruction
}

/* ********** ********** **********  Drawing ********** ********** **********  */

void draw(){
  if(state=="start"){
    Instructions();// start menu with instructions
    myTree();// tree figure
    myTree_2();// tree figure
  }
  else{
    background(#755AB2);
  // for every ball, it is given functions (bounce, color, shape, etc.)
  for(int i=0; i<balls.size(); i++) {
    ball b = (ball) balls.get(i);//casting ball object
    b.moveBall();
    b.display();
    b.Bounce();
  }
  myCircle();//centered circle
  }
}
/* ********** ********** **********  Functions ********** ********** **********  */

void mouseClicked(MouseEvent e) {
//makes sure the ball can shrink completely 
//and having the user click on the ball to shrink it
if(mouseButton==LEFT&&rad>=10 && state!="start"){
  if( mouseX <= (width/2)+70 && 
  mouseX >= (width/2)-70 && 
  mouseY <= 425 && 
  mouseY >= 285){
    rad-=10;//when the ball shrinks, the radius will shrink
    balls.add(new ball());// adds a ball everytime the centered ball shrinks
  }
}
 //allows the centered ball to grow to its original size
 //and makes sure that the user is clicking on the ball
 else if (mouseButton==RIGHT&&rad<200 && state!="start"){
   if( mouseX <= (width/2)+70 &&
   mouseX >= (width/2)-70 &&     
   mouseY <= 425 && 
   mouseY >= 285)
   {
     rad+=10;// radius is increased when the ball increases in size
   }
 }
}

void myCircle(){  
  ellipseMode(CENTER);// centers the ball
  fill(random(255), random(255), random(255));//fill the ball with different colors
  ellipse(height/2, width/2, rad,rad);
}

void myTree(){
  fill(#348B3A);
  triangle(0,650,120,450,240,650);//creates the top of the tree
  fill(#AF5C5C);
  rect(120,700,40,100);// creates the trunk
}

void myTree_2(){
  fill(#348B3A);
  triangle(700,650,580,450,450,650);//creates the top of the tree
  fill(#AF5C5C);
  rect(580,700,40,100);//creates the trunk of the tree
}

void keyPressed(){
  //closes the program when the user press the button "q"
  if (key=='q'|| key=='Q')
  exit();
}

void Instructions (){
  background(#A7C3FA);
  //creates the title in the center and gives the text color
  textFont(largeFont);
  textAlign(CENTER);
  fill(#000000);
  text("Infinite Bouncing Balls", width/2, 100); 
  
  // creates the instructions and gives the text color of them
  textFont(smallFont);
  textAlign(CENTER);
  fill(#000000);
  text("1. Left click on the centered ball to shrink the center ball", width/2, 200); 
  text("2. Right click on the centered ball to grow the ball", width/2, 240);  
  fill(#FF0505);//emphasizes the Note section for user
  text("Note", 125, 280);
  fill(#000000);
  text(":After the centered ball is completely shrunk, grow it", width/2, 280);
  text("Press q to quit", width/2, 320);
  
  // These lines create the start button
  stroke(#000000); // A color for the lines... Black
  strokeWeight(1); // The thickness of the lines
  fill(#ffffff);         // The color inside the lines
  rectMode(CENTER);
  rect((width/2), 600, 120, 50);
  textFont(largeFont);
  textAlign(CENTER);
  fill(#000000);
  text("START", width/2, 620); 
  
  // if the start button is clicked by using x and y coordinates of the mouse
  if (mousePressed == true) {
    if( mouseX <= (width/2)+60 && 
    mouseX >= (width/2)-60 &&
    mouseY <= 700 && 
    mouseY >= 580) 
    {
      state="ball";
    }
  }
}
/* ********** ********** **********  Classes ********** ********** **********  */ 
class ball {
  //ball class to contain all information regarding the ball
  float x;
  float y;
  float xspeed;
  float yspeed;
  float diam;
  // the color variations(red, green ,blue)
  float r;
  float g;
  float b;
  //Constructor: creates a ball of different color, speed, location, and size
  ball() { 
    //x and y coordinates
    x = random(30, 900);
    y =random(30, 350); 
    //diameter of ball
    diam = random(20, 60);
    //speed of ball
    xspeed = random(1, 5);
    yspeed = random(1, 2.8);
    //random colors
    r = random(256);
    g = random(256);
    b = random(256);
  }
  void moveBall() {
    //move the ball
    x+=xspeed;
    y+=yspeed;
  }  
  //displays the ball and fill in the color 
  void display() {
    noStroke();
    fill(r, g, b);
    ellipse(x,y,diam,diam);    
  }   
  void Bounce() {
    //change of direction when balls hit the walls 
    if(x>width-15) {
      xspeed*=-1;        
    }
    if(x<15) {
      xspeed*=-1;     
    }    
    if(y>height-15) {
      yspeed*=-1;
    }
    if( y<15) {
      yspeed*=-1;  
    }
  }
}
