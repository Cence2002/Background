ArrayList<Ball> balls;
float r, R;

void setup() {
  //size(600, 600);
  fullScreen();
  strokeCap(ROUND);

  R=min(width, height)*0.9;
  r=2;

  balls=new ArrayList<Ball>();
  for (int i=0; i<pow(R/2, 2)/1000; i++) {
    balls.add(new Ball(PVector.fromAngle(random(TWO_PI)).mult(sqrt(random(pow(R/2-r, 2)))), PVector.fromAngle(random(TWO_PI)).mult(random(0)), PVector.fromAngle(random(2*PI)).mult(0.3)));
    for (int j=0; j<10000; j++) {
      balls.get(i).move(0.1);
    }
  }
  //PVector.fromAngle(random(TWO_PI)).mult(sqrt(random(pow(R/2-r, 2)))), PVector.fromAngle(random(TWO_PI)).mult(random(0, 2))
  //new PVector(0, 0), new PVector(0, 1)
  frameRate(30);
}

void draw() {
  fill(0, 0, 0, 50);
  noStroke();
  rect(0, 0, width, height);
  stroke(255);
  noFill();
  translate(width/2, height/2);
  strokeWeight(2);
  ellipse(0, 0, R, R);
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
    if (p.mag()>R/2-r) {
      p.sub(v.copy().mult(t));
      v.rotate(PI-(-p.heading()+v.heading())*2);
    }
  }

  void show() {
    stroke(c);
    line(pp.x, pp.y, p.x, p.y);
  }
}
