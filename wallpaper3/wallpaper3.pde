ArrayList<Ball> balls;
float r;

void setup() {
  //size(100, 100);
  fullScreen();
  background(0);
  strokeCap(ROUND);

  r=1.5;

  balls=new ArrayList<Ball>();
  for (int i=0; i<width*height/10000; i++) {
    balls.add(new Ball(new PVector(random(r+(width-r*2)/4, width-r-(width-r*2)/4), random(r+(height-r*2)/4, height-r-(height-r*2)/4)), new PVector(0, 0), PVector.fromAngle(random(2*PI)).mult(1))); 
    for (int j=0; j<10000; j++) {
      balls.get(i).move(0.1);
    }
  }
  frameRate(30);
}

void draw() {
  fill(0, 0, 0, 50); 
  noStroke(); 
  rect(0, 0, width, height); 
  strokeWeight(r); 
  for (int i=0; i<balls.size(); i++) {
    balls.get(i).pp=balls.get(i).p.copy(); 
    for (int j=0; j<10; j++) {
      balls.get(i).move(0.1);
    }
    balls.get(i).show();
  }
  println(frameRate);
}

class Ball {
  PVector p, pp, v, g; 
  color c; 

  Ball(PVector p_, PVector v_, PVector g_) {
    p=p_.copy(); 
    v=v_.copy(); 
    g=g_.copy(); 
    c=color(random(255), random(255), random(255));
  }

  void move(float t) {
    v.add(g.copy().mult(t)); 
    p.add(v.copy().mult(t)); 
    if (p.x<=r/2||p.x>=width-r/2) {
      p.sub(v.copy().mult(t)); 
      v.x*=-1;
    } else if (p.y<r/2||p.y>height-r/2) {
      p.sub(v.copy().mult(t)); 
      v.y*=-1;
    }
  }

  void show() {
    stroke(c); 
    line(pp.x, pp.y, p.x, p.y);
  }
}
