function Q_full = DH_full(table, L)

    Q_full = eye(4);
    len = length(table(:,1));
    for i = 1:len
        if ((table(i,2) == 0) && (table(i,4) ~= 0))
            table(i,4) = table(i,4) - L(i)/2;
        elseif ((table(i,4) == 0) && (table(i,2) ~= 0))
            table(i,2) = table(i, 2) - L(i)/2;
        end
        Q_full = simplify(Q_full*DH_row(table(i,:)));
    end

    Q_full = simplify(Q_full);
    
end