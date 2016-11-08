// giunture = sfere
// link = cilindri (ma anche parallelepipedi)
int n_link = 3;
float angoloX = 0;
float angoloY = 0;
float angoloX_start = 0;
float angoloY_start = 0;

int radius = 25;
int w = 25;    // weight
int h = 25;    // height
int l = 100;    // depth

float[] q = new float[n_link];
float[] qr = new float[n_link];


int i;
int giunto;
int gomito = 1;

void setup()
{
    size(450, 450, P3D);   
}

void draw()
{
    background(100);
    translate(225, 225, -100);
    rotateY(-angoloY);
    rotateX(angoloX);
    rotateX(PI/3);
    
    // noStroke();
    // directionalLight(255, 255, 255, 1, 1, -1);
    
    for (i = 0; i < n_link; i++)
        q[i] -= 0.01*(q[i] - qr[i]);
        
    robot();
}

void robot()
{
    fill(#FF0000);
    pushMatrix();
    link(q[0], 100, PI/2, 0);
    link(q[1], 0, 0, 100);
    link(q[2], 0, 0, 100);
    popMatrix();
    
    fill(#00FF00);
    pushMatrix();
    link(qr[0], 100, PI/2, 0);
    link(qr[1], 0, 0, 100);
    link(qr[2], 0, 0, 100);
    popMatrix();
}

void link(float theta, float d, float alpha, float a)
{
    rotateZ(theta);
    sphere(radius);
    translate(0, 0, d/2);
    box(w, h, d);
    translate(0, 0, d/2);
    sphere(radius);
    rotateX(alpha);
    translate(a/2, 0, 0);
    box(a, h, w);
    translate(a/2, 0, 0);
}

void mousePressed()
{
    angoloY_start = angoloY + PI*mouseX/float(500);
    angoloX_start = angoloX + PI*mouseY/float(500);
}

void mouseDragged()
{
    angoloY = angoloY_start - PI*mouseX/float(500);
    angoloX = angoloX_start - PI*mouseY/float(500);
}

void keyPressed()
{
    if (keyCode >= 49 && keyCode < (49+n_link))
        giunto = keyCode - 49;
    if (keyCode == LEFT)
        qr[giunto] += 0.3;
    if (keyCode == RIGHT)
        qr[giunto] -= 0.3;
    if (key == 'g')
        gomito *= -1;
}