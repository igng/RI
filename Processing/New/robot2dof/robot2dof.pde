int l = 100;
int r = 15;
int n_link = 2;
int giunto = 0;
float[] q = new float[n_link];
float[] qr = new float[n_link];

float l1 = l;
float l2 = l;
float a;
int gomito = 1;
float x;
float y;

float b1;    //alpha
float b2;    //beta

void setup()
{
    size(450, 450);
}

void draw()
{
    background(100);
    trace_mouse();
    translate(225, 225);
    ellipse(0, 0, 4*l, 4*l);
    ellipse(x, y, 30, 30);
    a = (x*x + y*y - l1*l1 - l2*l2)/(2*l1*l2);
    qr[1] = atan2(gomito*sqrt(1 - a*a), a);
    b1 = l1 + cos(qr[1])*l2;
    b2 = sin(qr[1])*l2;
    qr[0] = atan2(-b2*x + b1*y, b1*x + b2*y) - PI/2;
    q[0] -= 0.05*(q[0] - qr[0]);
    q[1] -= 0.05*(q[1] - qr[1]);
    robot(0, 255, 0, 200, qr[0], qr[1]);
    robot(255, 0, 0, 200, q[0], q[1]);
    stroke(#FF0000);
    text("q1: " + str(q[0]), 150, 160);
    text("q2: " + str(q[1]), 150, 180);
    text("x: " + str(x), 150, 200);
    text("y: " + str(-y), 150, 220);
    stroke(000000);
}

void trace_mouse()
{
    float x_tmp, y_tmp;
    x_tmp = mouseX - 225;
    y_tmp = mouseY - 225;
    
    if (x_tmp*x_tmp + y_tmp*y_tmp <= (l1+l2)*(l1+l2))
    {
        x = x_tmp;
        y = y_tmp;
    }
}

void robot(int rr, int gg, int bb, int aa, float q1, float q2)
{
    pushMatrix();
        rotate(q1);
        link(rr, gg, bb, aa);
        translate(0, l);
        rotate(q2);
        link(rr, gg, bb, aa);
    popMatrix();
}

void link(int rr, int gg, int bb, int aa)
{
    fill(rr, gg, bb, aa);
    ellipse(0, 0, 2*r, 2*r);
    rect(-r, 0, 2*r, l);
    ellipse(0, l, 2*r, 2*r);
    fill(#FFFFFF);
}

void mousePressed()
{
    float x_tmp, y_tmp;
    x_tmp = mouseX - 225;
    y_tmp = mouseY - 225;
    
    if (x_tmp*x_tmp + y_tmp*y_tmp < (l1+l2)*(l1+l2))
    {
        x = x_tmp;
        y = y_tmp;
    }
}

void keyPressed()
{
    if (keyCode >= 49 && keyCode < (49+n_link))
        giunto = keyCode - 49;
    if (keyCode == LEFT)
        qr[giunto] += 0.3;
    if (keyCode == RIGHT)
        qr[giunto] -= 0.3;
}