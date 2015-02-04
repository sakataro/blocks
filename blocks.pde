int status;           //stasus number
int prize_num;
int BACK = 0;
float x;              //ball coodinate
float y;              //
float b_wid = 35;     //width of blocks
float b_hei = 10;     //height of blocks
float dx = 4.0;       //x speed of ball
float dy = -4.0;      //y speed of ball
float prize_y;
float prize_x;
float dy_pr = 3.0;
boolean start;
boolean wide_bar;
boolean blk[][] = new boolean[5][5];

void setup(){
  size(300, 500);
 // blocks();
  noStroke();
  smooth();
  background(0);
  fill(255);
  x = mouseX;
  y = 785;
  status = 0;
  start=false;
  wide_bar=false;
  for (int i = 0 ; i <= 4 ; i++) {
    for (int j = 0 ; j <=4 ; j++) {
      blk[i][j]=true;
    }
  }
}


  void draw(){
    background(BACK);
    //fill(0,50);
    //rect(width/2,height/2,width,height);
    bar();
    ball();
    blocks();
//    fall_prize();
  }

  void bar(){  
    strokeWeight(5);                                     //bar
    stroke(255);                                         //bar
    if (!wide_bar) {
      line(mouseX-20, height-20, mouseX+20, height-20);  //bar
    }
    else {                                               //wide
      line(mouseX-40, height-20, mouseX+40, height-20);  //wide
    }
  }
  
  void ball() {
     if (!start){
       //fill(255);
       ellipse(mouseX, height-25, 10, 10);
       x = mouseX;
       y = height-25;
       dx = -dx;
     }

      if (start) {
        x=x+dx;
        y=y+dy;
       // fill(255);
        if ((x < 5) || (x > width-5)){
          dx=-dx;
        }
        if (y < 5){
          dy=-dy;
        }
        if ((y > height-25) && (y < height-10)){
          if (!wide_bar) {
            if ((x > mouseX-20) && (x < mouseX+20)) { 
              dx+=(mouseX-pmouseX)*0.3;
              dy=-dy;
            }
          }
          else {
            if ((x > mouseX-40) && (x < mouseX+40)) { 
              dy=-dy;
            }            
          }
        }
        if (y > height+5){
           start = false;
        }
        ellipse(x,y, 10, 10);
      }
  }
  
void blocks(){
  //constant number 
  int i;
  int j;
  int k;
  float bx[] = new float[5];            //blocks coodinate
  float by[] = new float[5];            //
  float bar_r[] = new float[5];     //right  side
  float bar_l[] = new float[5];     //left   side
  float bar_u[] = new float[5];     //upper  side
  float bar_b[] = new float[5];     //bottom side    
  
  //deside blocks coordinate
  for (i = 0 ; i <= 4 ; i++) {
    bx[i] = width/2-b_wid*(2-i)*1.2;
    by[i] = height/2-b_hei*i*1.2;
    bar_r[i] = bx[i]+b_wid/2+5;     
    bar_l[i] = bx[i]-b_wid/2-5;     
    bar_u[i] = by[i]-b_hei/2-5;     
    bar_b[i] = by[i]+b_hei/2+5;         
  }
  
  //draw blocks
 // fill(255);
  rectMode(CENTER);
  for (i = 0 ; i <= 4 ; i++) {
    for (j =0 ; j <= 4 ; j++) {
      if (!blk[i][j]) {
        continue;
      }
      strokeWeight(2);
      stroke(150,0,120);
      rect(bx[i], by[j], b_wid, b_hei, 10 );
        if ((x >= bar_l[i]) && (x <= bar_r[i])) {
          if ((y >= bar_u[j]) && (y <= bar_b[j])) {
            if ((y-dy < bar_u[j]) || (y-dy > bar_b[j])) {
              dy = -dy;
            }
            if ((x-dx <= bar_l[i]) || (x-dx >= bar_r[i])) {
              dx = -dx;
            }
           blk[i][j]=false;
           prize_num = int(random(0,10));
           prize_x = bx[i];
           prize_y = by[j];
         }  
       }
    }
  }
}
 

void fall_prize() {
  if(prize_num==1){ 
    fill(0, 255, 255);
    stroke(10,200,255);
    ellipse(prize_x,prize_y,10,10);
    prize_y+=dy_pr;
  } 
  fill(255);
}
    
    
int counter = 0;    
void mouseClicked() {
  start=true;
  if (mouseButton == RIGHT) {
    if (status == 0) {
      wide_bar=true;
      status = 1;
    } else {
      wide_bar=false;
      status =0;
    }
  } /*else {
    if(start) {
     counter+= 1;
     if (counter%2 == 0) {
       BACK = 255;
     } else {
       BACK = 0;
     }
    }
   }*/
}


  
