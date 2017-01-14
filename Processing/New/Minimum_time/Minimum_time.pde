boolean select = true;           /* true = start; false = stop */
boolean start = false;           /* true = compute trajectories */
boolean mou_ichi_do = false;     /* true = redraw everything */
boolean commute = false;         /* true = draw commutation trajectory */
boolean ending = false;          /* true = performing final approach */

float radius = 10;
float resol = 3;
float tollerance = 20/resol;
float lower_bound = -50;
float upper_bound = 50;
float curr_y;
float a = 1;
float dist_switch = 0;
float dist_arrive = 0;
int ms_delay = 50;

float x, y;

float start_x, start_y, stop_x, stop_y;
float c_gr, c_gf, c_rr, c_rf;

void setup()
{
    size(1000, 500);
    background(#15E8D4);
    y = -10;
}

void draw()
{
    
    if (mou_ichi_do)
        background(#15E8D4);
        
    display_text();
    create_reference();
    display_points(start_x, start_y, stop_x, stop_y);
    display_trajectories();
    if (commute)
        compute_commutation();
}

void keyPressed()
{
    if (key == ENTER)
    {
        commute = true;
        ending = false;
    }
}

void mouseClicked()
{
    if (select)
    {
        start_x = mouseX - 500;
        start_y = mouseY - 250;
        c_gr = start_x - start_y*start_y/(2*a);
        c_gf = start_x - start_y*start_y/(-2*a);
        start = false;
        y = start_y;
    }
    else
    {
        stop_x = mouseX - 500;
        stop_y = mouseY - 250;
        c_rr = stop_x - stop_y*stop_y/(2*a);
        c_rf = stop_x - stop_y*stop_y/(-2*a);
        mou_ichi_do = false;
        start = true;
        background(#15E8D4);
        curr_y = lower_bound;
        println();
        println("-----------------------------");
        println();
    }
    
    select  = !select;
}

void display_text()
{
    fill(#FC7200);
    text("Start: (" + start_x + ", " + start_y + ")", 50, 50);
    text("Stop: (" + stop_x + ", " + stop_y + ")", 50, 70);
    text("c_gr: " + c_gr, 50, 100);
    text("c_gf: " + c_gf, 50, 120);
    text("c_rr: " + c_rr, 50, 140);
    text("c_rf: " + c_rf, 50, 160);
}

void create_reference()
{
    strokeWeight(3);
    line(150, 250, 850, 250);
    line(500, 50, 500, 450);
    translate(500, 250);
}

void display_points(float start_x, float start_y, float stop_x, float stop_y)
{
    green(start_x, start_y);
    red(stop_x, stop_y);
}

void green(float x, float y)
{
    strokeWeight(2);
    fill(#00FF00);
    ellipse(x, y, radius, radius);
}

void red(float x, float y)
{
    strokeWeight(2);
    fill(#FF0000);
    ellipse(x, y, radius, radius);
}

void blue(float x, float y)
{
    fill(#0000FF);
    ellipse(x, y, radius, radius);
}

float green_rising(float y)
{
    return (y*y/(2*a) + c_gr);
}

float green_falling(float y)
{
    return (y*y/(-2*a) + c_gf);
}

float red_rising(float y)
{
    return (y*y/(2*a) + c_rr);
}

float red_falling(float y)
{
    return (y*y/(-2*a) + c_rf);
}

void display_trajectories()
{
    float rise_gx, fall_gx, rise_rx, fall_rx;
    // Trajectory is x = y²/2a + (2ac_2 - c_1^2)/2a, assuming the latter term as a generic "c"
    if (start)
    {
        if (curr_y <= upper_bound)
        {
            curr_y = curr_y + 1/resol;
            rise_gx = green_rising(curr_y);
            fall_gx = green_falling(curr_y);
            rise_rx = red_rising(curr_y);
            fall_rx = red_falling(curr_y);
            
            custom_point(rise_gx, curr_y, #00FF00);
            custom_point(fall_gx, curr_y, #00FF00);
            custom_point(rise_rx, curr_y, #FF0000);
            custom_point(fall_rx, curr_y, #FF0000);
        }
        else
            start = false;
    }
}

void custom_point(float x, float y, int c)
{
    strokeWeight(0.5);
    fill(c);
    ellipse(x, y, radius/2, radius/2);
}

void compute_commutation()
{
    boolean cond1 = ((stop_x < green_rising(stop_y)) && (stop_y < start_y));
    boolean cond2 = ((stop_x > green_rising(stop_y)) && (stop_y > start_y));
    
    if (cond1 || cond2)
        fall_and_rise();
    else
        rise_and_fall();
}

void rise_and_fall()
{
    println("Rise and fall");
    dist_arrive = dist(x, y, stop_x, stop_y);
    dist_switch = dist(x, y, red_falling(y), y);
    
    if (ending)
    {
        if (dist_arrive > tollerance)
        {
            y = y + 1/resol;
            x = red_falling(y);
            blue(x, y);
        }
        else
            commute = false;
    }
    else
    {
        if ((dist_switch > tollerance) || (y > stop_y))
        {
            y = y - 1/resol;
            x = green_rising(y);
            blue(x, y);
        }
        else
        {
            println("\t\tSWITCHING!");
            ending = true;
        }
    }
    
    println("Dist_switch: " + dist_switch);
    println("Dist_arrive: " + dist_arrive);
    println();
    delay(ms_delay);
}

void fall_and_rise()
{
    println("Fall and rise");
    dist_arrive = dist(x, y, stop_x, stop_y);
    dist_switch = dist(x, y, red_rising(y), y);
    
    if (ending)
    {
        if (dist_arrive > tollerance)
        {
            y = y - 1/resol;
            x = red_rising(y);
            blue(x, y);
        }
        else
            commute = false;
    }
    else
    {
        if ((dist_switch > tollerance) || (y < stop_y))
        {
            y = y + 1/resol;
            x = green_falling(y);
            blue(x, y);
        }
        else
        {
            println("\t\tSWITCHING!");
            ending = true;
        }
    }
    
    println("Dist_switch: " + dist_switch);
    println("Dist_arrive: " + dist_arrive);
    println();
    delay(ms_delay);
}