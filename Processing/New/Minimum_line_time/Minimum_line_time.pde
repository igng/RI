boolean ready = false;           /* true = start; false = stop */
boolean start = false;           /* true = compute trajectories */
boolean mou_ichi_do = false;     /* true = redraw everything */
boolean commute = false;         /* true = draw commutation line */
boolean ending = false;          /* true = performing final approach */
boolean traject = false;         /* true = compute trajectory */

float start_x, start_y, stop_x, stop_y;
float c_gr, c_gf, c_rr, c_rf;

float radius = 10;
float resol = 3;
float step = 1/resol;
float tollerance = 30/resol;
float lower_bound = -50;
float upper_bound = 50;
float a = 1;
float dist_switch = 0;
float dist_arrive = 0;
int ms_delay = 10;
/* ----------------- */
float comm_old_y = lower_bound;
float comm_old_x = red_falling(comm_old_y);
float comm_new_y = comm_old_y;
float comm_new_x = comm_old_x;
/* --- */
float traj_old_y = start_y;
float traj_old_x = start_x;
float traj_new_y = traj_old_y;
float traj_new_x = traj_old_x;

/* ----------------- */
float x, y;

void setup()
{
    size(1000, 500);
    background(#15E8D4);
    y = -10;
}

void draw()
{
    if (mou_ichi_do)
    {
        background(#15E8D4);
        mou_ichi_do = false;
    }
        
    //display_text();
    create_reference();
    scale(0.8);
    display_points(start_x, start_y, stop_x, stop_y);
    display_commutation();
    compute_trajectory();
}

void keyPressed()
{
    if (key == ENTER)
    {
        ending = false;
        traject = true;
        commute = false;
    }
}

void mouseClicked()
{
    if (ready)
    {
        start_x = mouseX - 500;
        start_y = mouseY - 250;
        c_gr = start_x - start_y*start_y/(2*a);
        c_gf = start_x - start_y*start_y/(-2*a);
        y = start_y;
        traj_old_y = start_y;
        traj_old_x = start_x;
        traj_new_y = traj_old_y;
        traj_new_x = traj_old_x;
    }
    else
    {
        stop_x = mouseX - 500;
        stop_y = mouseY - 250;
        c_rr = stop_x - stop_y*stop_y/(2*a);
        c_rf = stop_x - stop_y*stop_y/(-2*a);
        mou_ichi_do = true;
        traject = false;
        commute = true;
        background(#15E8D4);
        comm_old_y = lower_bound;
        comm_old_x = red_falling(comm_old_y);
        comm_new_y = comm_old_y;
        comm_new_x = comm_old_x;
        println();
        println("-----------------------------");
        println();
    }
    
    ready  = !ready;
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
    stroke(#000000);
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
    strokeWeight(1);
    fill(#00FF00);
    ellipse(x, y, radius, radius);
    strokeWeight(3);
}

void red(float x, float y)
{
    strokeWeight(1);
    fill(#FF0000);
    ellipse(x, y, radius, radius);
    strokeWeight(3);
}

void blue(float old_x, float old_y, float new_x, float new_y)
{
    stroke(#0000FF);
    strokeWeight(3);
    line(old_x, old_y, new_x, new_y);
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

void display_commutation()
{
    // Trajectory is x = y²/2a + (2ac_2 - c_1^2)/2a, assuming the latter term as a generic "c"
    if (commute)
    {
        println("Comm_new_y: " + comm_new_y + "\tstop_y: " + stop_y);
        if (comm_new_y <= stop_y)
        {
            comm_old_y = comm_new_y;
            comm_new_y = comm_old_y + step;
            comm_old_x = red_falling(comm_old_y);
            comm_new_x = red_falling(comm_new_y);
            
            stroke(#FF0000);
            line(comm_old_x, comm_old_y, comm_new_x, comm_new_y);
        }
        if ((comm_new_y > stop_y) && (comm_new_y < upper_bound))
        {
            comm_old_y = comm_new_y;
            comm_new_y = comm_old_y + step;
            comm_old_x = red_rising(comm_old_y);
            comm_new_x = red_rising(comm_new_y);
            
            stroke(#FF0000);
            line(comm_old_x, comm_old_y, comm_new_x, comm_new_y);
        }
    }
}

void compute_trajectory()
{
    if (traject)
    {
        boolean cond1 = ((stop_x < green_rising(stop_y)) && (stop_y < start_y));
        boolean cond2 = ((stop_x > green_rising(stop_y)) && (stop_y > start_y));
            
        if (cond1 || cond2)
            fall_and_rise();
        else
            rise_and_fall();
    }
}

void rise_and_fall()
{
    println("Rise and fall");
    dist_arrive = dist(traj_new_x, traj_new_y, stop_x, stop_y);
    dist_switch = dist(traj_new_x, traj_new_y, red_falling(traj_new_y), traj_new_y);
    
    if (ending)
    {
        if (dist_arrive > tollerance)
        {
            traj_old_y = traj_new_y;
            traj_new_y = traj_old_y + step;
            traj_old_x = red_falling(traj_old_y);
            traj_new_x = red_falling(traj_new_y);
            stroke(#0000FF);
            line(traj_old_x, traj_old_y, traj_new_x, traj_new_y);
        }
    }
    else
    {
        if ((dist_switch > tollerance) || (traj_new_y > stop_y))
        {
            traj_old_y = traj_new_y;
            traj_new_y = traj_old_y - step;
            traj_old_x = green_rising(traj_old_y);
            traj_new_x = green_rising(traj_new_y);
            stroke(#0000FF);
            line(traj_old_x, traj_old_y, traj_new_x, traj_new_y);
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
    dist_arrive = dist(traj_new_x, traj_new_y, stop_x, stop_y);
    dist_switch = dist(traj_new_x, traj_new_y, red_rising(traj_new_y), traj_new_y);
    
    if (ending)
    {
        if (dist_arrive > tollerance)
        {
            traj_old_y = traj_new_y;
            traj_new_y = traj_old_y - step;
            traj_old_x = red_rising(traj_old_y);
            traj_new_x = red_rising(traj_new_y);
            stroke(#0000FF);
            line(traj_old_x, traj_old_y, traj_new_x, traj_new_y);
        }
    }
    else
    {
        if ((dist_switch > tollerance) || (traj_new_y < stop_y))
        {
            traj_old_y = traj_new_y;
            traj_new_y = traj_old_y + step;
            traj_old_x = green_falling(traj_old_y);
            traj_new_x = green_falling(traj_new_y);
            stroke(#0000FF);
            line(traj_old_x, traj_old_y, traj_new_x, traj_new_y);
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