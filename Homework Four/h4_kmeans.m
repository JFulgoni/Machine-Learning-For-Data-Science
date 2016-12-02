% John Fulgoni
% Homework 4
% Problem 1 - K Means Algorithm
% Due 14 April 2015

clc;
clear;
close all;

%% Set up variables

n = 500;

pi = [0.2, 0.5, 0.3];

MU = [0, 0; 3, 0; 0, 3];
sigma1 = [1, 0; 0, 1];
sigma2 = [1, 0; 0, 1];
sigma3 = [1, 0; 0, 1];

SIGMA = cat(3, sigma1, sigma2, sigma3);

obj = gmdistribution(MU,SIGMA,pi);

xi = random(obj,n);

%% for each value of K

for K = 2 : 5
    
ci = zeros(500,1);

mu_k = random(obj,K); % randomize class mu to start off

obj_sum = zeros(20,1);


%% for 20 iterations

for iter = 1 : 20
%% Update ci given ui

objective = zeros(500,1);

for i = 1 : size(xi,1)   
    for k = 1 : K
        if(k == 1)
            kclass = 1;
            cmin = norm(xi(i,:) - mu_k(k,:));
        else
            ctemp = norm(xi(i,:) - mu_k(k,:));
            if (ctemp < cmin)
                cmin = ctemp;
                kclass = k;
            end
        end
    end
    ci(i) = kclass;
    objective(i) = cmin;
end

obj_sum(iter) = sum(objective);

%% Then update ui given ci

for k = 1 : K
    k_index = find(ci==k);
    k_data = xi(k_index,:);
    
    k_sum = sum(k_data,1);
    
    mu_k(k,:) = k_sum / size(k_data,1);
end

%% end iterations
end

%% Plot
class = num2str(K); %number of classes

figure(1);
subplot(2,2,(K-1));
gscatter(xi(:,1),xi(:,2),ci,'brgyc','xohsd');
title(strcat('Scatter Plot after 20 iterations, K = ',class));

figure(2)
subplot(2,2,(K-1));
plot(obj_sum,'r','LineWidth',2);
title(strcat('Objective Function Value over 20 iterations, K = ',class));
xlabel('Iterations');

%% end K
end

disp(mu_k);