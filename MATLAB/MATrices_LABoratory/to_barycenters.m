function Qs = to_barycenters(table, L)
    % for every link, compute the Denavit-Hartenberg that goes to the bc
    
    len = length(table(:,1));   % number of joints
    barycentric = sym(zeros(len, 4));
    Qs = sym(zeros(4, 4, len));      % len matrix 4x4
    for i = 1:len
       for j = 1:i-1
           barycentric(j,:) = table(j,:);
       end
       if ((table(i,4) == 0) && (table(i, 2) ~= 0))
           barycentric(i, :) = [table(i,1), table(i, 2) - L(i)/2, table(i,3), table(i,4)];
       elseif ((table(i, 4) ~= 0))
           barycentric(i, :) = [table(i,1), table(i, 2), table(i,3), table(i,4) - L(i)/2];
       else
           barycentric(i,:) = table(i,:);
       end
       
       Qs(:,:,i) = DH_full(barycentric);
    end
end