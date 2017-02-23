function Q_row = DH_row(row)
    
    if (length(row(1,:)) ~= 4)
        fprintf('==> ERROR: invalid row of the table\n');
        fprintf('  => Returning zero matrix\n');
        Q_row = zeros(4);
        return;
    end
    Av_z = screw([0, 0, 1], row(1), row(2));
    Av_x = screw([1, 0, 0], row(3), row(4));

    Q_row = Av_z * Av_x;

end