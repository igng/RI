// giunture = sfere
// link = cilindri (ma anche parallelepipedi)

int size_x = 450;
int size_y = 450;

int n_link = 5;
float angoloX = 0;
float angoloY = 0;
float angoloX_start = 0;
float angoloY_start = 0;

int radius = 25;

int l1 = 100;
int l2 = 100;

float[] q = new float[n_link];
float[] qr = new float[n_link];

int i;
int giunto;
char struct = 'c';

void setup()
{
    size(900, 650, P3D);
    size_x = 900;
    size_y = 650;
}

void draw()
{
    background(#2297E3);
    display_info();
    translate(size_x/2, size_y/2, -100);
    rotateY(-angoloY);
    rotateX(angoloX);
    rotateX(PI/3);
    
    // noStroke();
    // directionalLight(255, 255, 255, 1, 1, -1);
    
    if (keyPressed)
        handle_key_pressed();
    
    for (i = 0; i < n_link; i++)
        q[i] -= 0.08*(q[i] - qr[i]);
      
    show_axis();
}

void show_axis()
{
    strokeWeight(5);
    textSize(20);

    stroke(#FF0000);
    line(-100, 0, 0, 100, 0, 0);
    fill(#FF0000);
    text("X", 100, 0, 0);

    stroke(#FA6305);
    line(0, -100, 0, 0, 100, 0);
    fill(#FA6305);
    text("Y", 0, 100, 0);

    stroke(#000000);
    line(0, 0, -100, 0, 0, 100);
    fill(#000000);
    text("Z", 0, 0, 100);
}

void cylinder(int sides, float radius, float h)
{
    float angle = 360/sides;
    float x;
    float y;
    float half = h/2;
    beginShape();
    for (int i = 0; i < sides; i++)
    {
        x = radius*cos(radians(i*angle));
        y = radius*sin(radians(i*angle));
        vertex(x, y, -half);
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++)
    {
        x = radius*cos(radians(i*angle));
        y = radius*sin(radians(i*angle));
        vertex(x, y, half);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides; i++)
    {
        x = radius*cos(radians(i*angle));
        y = radius*sin(radians(i*angle));
        vertex(x, y, half);
        vertex(x, y, -half);
    }
    endShape(CLOSE);
} 

void display_info()
{
    textSize(15);
    fill(#000000);
    for (i = 0; i < n_link; i++)
    {
        text("qr" + str(i+1) + ": " + str(qr[i]), 200, 60+20*i);
        text("q" + str(i+1) + ": " + str(q[i]), 50, 60+20*i);
    }
}

void cartesiano()
{
    pushMatrix();
        fill(#FC6A08);
        link(0, q[0], -PI/2, 0);
        link(-PI/2, q[1], -PI/2, 0);
        link(0, q[2], 0, 0);
    popMatrix();
}

void cilindrico()
{
    pushMatrix();
        fill(#FC6A08);
        link(q[0], l1, 0, 0);
        link(0, q[1], -PI/2, 0);
        link(0, q[2], 0, 0);
    popMatrix();
}

void scara()
{
    pushMatrix();
        fill(#FC6A08);
        link(q[0], 0, 0, l1);
        link(q[1], l2, 0, 0);
        link(0, q[2], 0, 0);
    popMatrix();
}

void polso_sferico()
{
    pushMatrix();
        fill(#FC6A08);
        link(q[0], 0, -PI/2, 0);
        link(q[0], 0, PI/2, 0);
        link(q[0], l1, 0, 0);
    popMatrix();
}

void robot()
{
    switch (struct)
    {
        /* cartesiana */
        case 'z':
            cartesiano();
            break;
        case 'x':
            cilindrico();
            break;
        case 'c':
            scara();
            break;
        case 'v':
            polso_sferico();
            break;
    }
}

void link(float theta, float d, float alpha, float a)
{
    rotateZ(theta);
    sphere(radius);
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
}

void handle_key_pressed()
{
    if (keyCode == LEFT)
        qr[giunto] += 0.7;
    else if (keyCode == RIGHT)
        qr[giunto] -= 0.7;
    else
    {
        switch (key)
        {
            case 'Z':
            case 'z':
            case 'X':
            case 'x':
            case 'C':
            case 'c':
            case 'V':
            case 'v':
                struct = key;
                break;
        }
    }
}