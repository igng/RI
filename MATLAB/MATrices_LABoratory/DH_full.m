function Q_full = DH_full(table)

    Q_full = eye(4);
    len = length(table(:,1));
    if (length(table(1,:)) ~= 4)
        fprintf('==> ERROR: wrong DH table.\n');
        fprintf('  => Returning zero matrix\n');
        Q_full = zeros(4);
        return;
    end
    for i = 1:len
        Q_full = simplify(Q_full*DH_row(table(i,:)));
    end

    Q_full = simplify(Q_full);
    
end