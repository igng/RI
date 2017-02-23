function Q_full = DH_full(table)

    Q_full = eye(4);
    len = length(table(:,1));
    for i = 1:len
        Q_full = simplify(Q_full*DH_row(table(i,:)));
    end

    Q_full = simplify(Q_full);
    
end