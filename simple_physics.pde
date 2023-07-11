float mousrad = 50;

float diameter = 20;
float draw_diameter = 20;

float qattylyq = 0.2;


////////////////////////////// elements positions and velocities
int n = 500;

float[] x2 = new float[n];
float[] y2 = new float[n];

float[] dx2 = new float[n];
float[] dy2 = new float[n];
/////////////////////////////////////////////////////////////////


void setup(){
  //fullScreen();
  size(800, 800);
  
  noStroke();
  background(0,0,0);
  
  fill(0);

  for (int i=0; i<n; i++){
    x2[i] = random(width);
    y2[i] = random(height);
      
    dx2[i] = 0;
    dy2[i] = 0;
  }
}




void draw(){
  background(255);
  
  float x1 = mouseX;
  float y1 = mouseY;
  
  circle(x1, y1, mousrad*2);
  
  for(int i=0; i<n; i++){

    ///////////////////////////////////////////////////////////////// mouse collusion
    float dis = sqrt(pow(x1-x2[i],2) + pow(y1-y2[i],2));
    
    if(dis < mousrad+(diameter/2)){
      float ddi = (mousrad+(diameter/2)-dis)/2;
      
      x2[i] = x2[i] + ((mousrad+(diameter/2)-dis)*(x2[i]-x1))/(dis);
      y2[i] = y2[i] + ((mousrad+(diameter/2)-dis)*(y2[i]-y1))/(dis);
      
      dx2[i] += (ddi*(x2[i]-x1))/(dis);
      dy2[i] += (ddi*(y2[i]-y1))/(dis);
    }
    
    //ainalu
    //dx2[i] -= 5*((1/dis)*(y2[i]-y1))/(dis);
    //dy2[i] += 5*((1/dis)*(x2[i]-x1))/(dis);
    
    //tartu
    //dx2[i] -= 40*((1/dis)*(x2[i]-x1))/(dis);
    //dy2[i] -= 40*((1/dis)*(y2[i]-y1))/(dis);
    /////////////////////////////////////////////////////////////////
    
    
    ////gravity
    dy2[i] += 0.1;
    
    
    //////////////////////////////////////////// bir birine collusion ////////////
    for(int j=0; j<n; j++){
      if(i != j){
        
        float disin = sqrt(pow((x2[j]-x2[i]),2) + pow((y2[j]-y2[i]),2));
        
        if(disin < diameter){
          float ddin = qattylyq*(diameter-disin);
          
          float ijx = (x2[j]-x2[i]);
          float ijy = (y2[j]-y2[i]);
          
          dx2[i] -= ddin*(ijx/(disin));
          dy2[i] -= ddin*(ijy/(disin));
          
          dx2[j] += ddin*(ijx/(disin));
          dy2[j] += ddin*(ijy/(disin));
          
          
          x2[i] -= ddin*(ijx/(disin));
          y2[i] -= ddin*(ijy/(disin));
          
          x2[j] += ddin*(ijx/(disin));
          y2[j] += ddin*(ijy/(disin));
        }
      }
    }
    x2[i] += dx2[i];
    y2[i] += dy2[i];
    ///////////////////////////////////////////////////////////////////////////////////
    
    
    //////////////////////////////////////// wall collusion //////////    
    if(y2[i] > height - (diameter/2)){
      y2[i] = height - (diameter/2);
      dy2[i] = -dy2[i]*0.1;
    }
    if(y2[i] < diameter/2){
      y2[i] = diameter/2;
      dy2[i] = -dy2[i]*0.1;
    }
    
    if(x2[i] > width - (diameter/2)){
      x2[i] = width - (diameter/2);
      dx2[i] = -dx2[i]*0.1;
    }
    if(x2[i] < diameter/2){
      x2[i] = diameter/2;
      dx2[i] = -dx2[i]*0.1;
    }
    /////////////////////////////////////////////////////////////////
    
    
    
    //drawing
    circle(x2[i], y2[i], draw_diameter);
  }  
}
