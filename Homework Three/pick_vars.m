function [ classes ] = pick_vars(w, n);
% John Fulgoni
% COMS 4721
% Homework 3
% Discrete Random Variable Function


%n = 500; % number of random variables
%w = [0.1;0.2;0.3;0.4]; % probability distribution
k = size(w,1);

vars = rand(n,1);
classes = zeros(n,1);
cdfunction = zeros(k,1);

for i = 1 : size(w,1)
    if (i ==1)
        cdfunction(i) = w(i);
    else
        cdfunction(i) = w(i) + cdfunction(i-1);
    end
end

for i = 1 : size(vars,1)
    check = 0;
    for j = 1 : k
        %disp('J');
        %disp(j);
        if(vars(i) < cdfunction(j))
            %disp('Check');
            %disp(check);
            if(check == 0)
                  classes(i) = j;
                  check = 1;
                  %disp('Check');
                  %disp(check);
                  %disp('Pass');  
                  %disp(vars(i));
                  %disp(cdfunction(j));
            end
        end
    end
    %disp(i);
end

%disp('Classes');
%disp(classes);

end