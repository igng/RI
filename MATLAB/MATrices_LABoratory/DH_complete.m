function Q_full = DH_full(table)

    Q_full = eye(4);
    len = length(table(:,1));
    for i = 1:len
        Q_full = Q_full*Q_rot(table(i,:));
    end
    
end