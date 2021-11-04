int gridsize = 50;
Orb[] orbs;
Orb[] pointers;
void setup() {
   orbs = new Orb[gridsize*gridsize];
   size(1080, 1080);
   background(255);

   pointers = new Orb[3];
   int count = 0;
   for (int i = 1; i <= pointers.length; i++){
      float radians = 2*PI*i/pointers.length;
      println(radians);
      float[] xy = xyfromradians(radians);
      Orb pointer = new Orb(xy[0], xy[1], radians);
      pointers[count] = pointer;
      count += 1;
   }


   count = 0;
   for (int i = 1; i < gridsize; i++) {
      for (int j = 1; j < gridsize; j++) {
         float x = width*i/gridsize;
         float y = height*j/gridsize;
         Orb orb = new Orb(x,y, 0);
         orb.display();
         orbs[count] = orb;
         count += 1;
      }
   }
}
float radius = width*3.5;
float[] xyfromradians(float radians){
   float[] xy = new float[2];
   xy[0] = radius * cos(radians) + width/2;
   xy[1] = radius * sin(radians) + height/2;
   return xy;
}

void draw() {
   background(255);
   for (int i = 0; i < ((gridsize-1)*(gridsize-1)); i++){
      orbs[i].display();
   }
   for (int i = 0; i < pointers.length; i++) {
      pointers[i].move();
      pointers[i].displayp();
   }
}


class Orb {
   float orb_size;
   float x_speed;
   float y_speed;
   float xpos;
   float ypos;
   float angle;
   
   public Orb(float x, float y, float a){
      angle = a;
      orb_size = random(1,3) * height/40.0;
      x_speed = random(-1, 1);
      y_speed = random(-1, 1);
      xpos = x;
      ypos = y;
   }
   
   void display(){
      noStroke();
      fill(0);
      boolean in = false;
      float dist = width;
      for (int i = 0; i < pointers.length; i++) {
         float temp_dist = distance(pointers[i].xpos, pointers[i].ypos, xpos, ypos);
         if (temp_dist < dist){
            dist = temp_dist;
         }
      }
      dist = dist / 50.0;
      float tempsize = orb_size / (dist + 2);
      ellipse(xpos, ypos, tempsize, tempsize);
   }
   
   void displayp(){
      noStroke();
      noFill();
      // float tempsize = orb_size;
      ellipse(xpos, ypos, orb_size, orb_size);

   }
   
   void move(){
      angle += radians(1);
      if (angle > 2*PI) {
         angle -= 2*PI;
      }
      float[] xy = xyfromradians(angle);
      xpos = xy[0];
      ypos = xy[1];
   } 
}

float distance(float x1, float y1, float x2, float y2){
   return (float)Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
}

float prop(float value){
   return value * width / 512;
}