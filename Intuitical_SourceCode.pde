int radius = 15;
float x0 = 500;  //random(0+radius,screenX-radius);
float y0 = 500;  //random(0+radius,screenY-radius);
float vx = 0;
float vy = 300000;
float m = 10;
float Fx = 0;
float Fy = 0;

float x = x0;
float y = y0;

int squareside = 50;
int squarestartposX = 1100;
int squarestartposY = 425;

float time = 0;
int dt = 1;
int counter = 0;
int gamecounter = 0;
float distanceX;
float distanceY;

PrintWriter file;
PrintWriter mouseData;

void setup()
{
  size(1850,950);
  background(127);

  
  delay(1000);
  
  stroke(0);
  fill(200);
  rect(50,50,1800,900);
  stroke(200); 
  fill(255);
  line(0,475,100,475);
  line(900,0,900,100);

  stroke(255,0,0); 
  fill(255,0,0);
  ellipse(x,y,2*radius,2*radius); 
  
  stroke(0);
  fill(0);
  rect(squarestartposX,squarestartposY,3*radius,3*radius);
  

  
  file = createWriter("results001.txt");  
  mouseData = createWriter("mouseData001.txt");
  
  mouseData.println("game \t count \t mouseX \t mouseY \t x \t y");
  mouseData.flush();


  delay(1000);

}

void draw()
{

  if(abs(x - (squarestartposX + squareside/2)) < 10 && abs(y - (squarestartposY + squareside/2)) <= 10)
  {
   background(0);
   textSize(50); // Set text size to 32
   fill(0,255,0);
   text(counter, 700, 500);
   file.println(gamecounter + "\t" + counter);
   file.flush();
   mouseData.println("game \t count \t mouseX \t mouseY \t x \t y");
   mouseData.flush();
   
 
   delay(3000);
   // initialize new game
   x0 = 500;  //random(0+radius,screenX-radius);
   y0 = 500;  //random(0+radius,screenY-radius);
   vx = 0;
   vy = 300000;
   Fx = 0;
   Fy = 0;
   x = x0;
   y = y0;
   counter = 0;
   gamecounter++;
  }

  
  
  //draw "playground"
  // background(127+cos(time/200)*127);
  background(255);
  stroke(0);
  fill(200);
  rect(50,50,1800,900);
  stroke(200); 
  fill(255);
  line(0,475,100,475);
  line(925,0,925,100);
  textSize(50);
  fill(0,255,0);
  text(counter, 5, 40);
 

  // determine forces
  //Fx = cos(time/20)*(mouseX - 100)/10+sin(time/20)*(mouseY - 100)/10; super hard and fast
  //Fy = cos(time/20)*(mouseY - 100)/10+sin(time/20)*(mouseX - 100)/10; super hard and fast
  //Fy = (cos(time/200)+sin(time/200))*(mouseY - 100)/10;
  Fx = cos(time/200)*(mouseY - 475)/30;
  Fy = sin(time/200)*(mouseY - 475)/30;
  
  stroke(0);
  line(0,Fy*28+475,50,Fy*28+475);
  line(Fx*58+925,0,Fx*58+925,50);
  
  //reflect at the walls
  if(x <= 50)
   vx = -vx;
  if(x >= 1850)
   vx = -vx;
  if(y <= 50)
   vy = -vy;
  if(y >= 950)
   vy = -vy;   
  
  // x kinetics
  x = x + 0.00001*vx;  
  vx = 0.995*vx + 100*Fx;

  // y kinetics
  y = y + 0.00001*vy;  
  vy = 0.995*vy + 100*Fy;

  // draw goal
  stroke(0);
  fill(0);
  rect(squarestartposX,squarestartposY,3*radius,3*radius);

  // draw cirlce
  stroke(255,0,0); 
  fill(255,0,0);
  ellipse(x,y,2*radius,2*radius); 
  

  
  // time evolution
  delay(dt);
  time += dt;
  counter++;

 
  mouseData.println(gamecounter + "\t" + counter +"\t"+ mouseX + "\t" + mouseY + "\t" + x + "\t" + y);
  mouseData.flush();

}