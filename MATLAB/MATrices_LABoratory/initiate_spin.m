function [q, L] = initiate_spin()
    
    close all;
    clearvars;
    syms t L1 L2 L3 L4 L5 L6
    q1 = sym('q1(t)');
    q2 = sym('q2(t)');
    q3 = sym('q3(t)');
    q4 = sym('q4(t)');
    q5 = sym('q5(t)');
    q6 = sym('q6(t)');

    clc
    q = [q1 q2 q3 q4 q5 q6];
    L = [L1 L2 L3 L4 L5 L6];

end