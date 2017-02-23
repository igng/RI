function I = initiate_inertia()
    
    fprintf('==> Initializing inertia...\n');
    syms I1 I2 I3 I4 I5 I6;
    syms I1x I1y I1z I2x I2y I2z I3x I3y I3z;
    syms I4x I4y I4z I5x I5y I5z I6x I6y I6z;
    I1 = diag([I1x, I1y, I1z]);
    I2 = diag([I2x, I2y, I2z]);
    I3 = diag([I3x, I3y, I3z]);
    I4 = diag([I4x, I4y, I4z]);
    I5 = diag([I5x, I5y, I5z]);
    I6 = diag([I6x, I6y, I6z]);

    I = [I1 I2 I3 I4 I5 I6];
end