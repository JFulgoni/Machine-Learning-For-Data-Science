% John Fulgoni
% Homework 5
% Problem 5 Part 1 Markov Chains

clc;
clear;
close all;

load('CFB2014.mat');

%% Initialize Random Walk Matrix

M = zeros(759,759);

for g = 1 : size(scores,1)
    team1 = scores(g,1);
    team2 = scores(g,3);
    
    score1 = scores(g,2);
    score2 = scores(g,4);
    
    if(score1 > score2)
        won1 = 1;
        won2 = 0;
    else
        won1 = 0;
        won2 = 1;
    end
    
    M(team1,team1) = M(team1,team1) + won1 + (score1/(score1+score2));
    M(team2,team2) = M(team2,team2) + won2 + (score2/(score1+score2));
    M(team1,team2) = M(team1,team2) + won2 + (score2/(score1+score2));
    M(team2,team1) = M(team2,team1) + won1 + (score1/(score1+score2));
end

% normalize the rows so they sum to 1
for row = 1 : size(M,1)
    sum_row = sum(M(row,:));
    M(row,:) = M(row,:)/sum_row;
end

%% Iterate through values of T

t_values = [10,100,200,500,1000];
best20 = cell(21,5);
winfinite = zeros(1000,1); %store values of l1 norm


for iter = 1 : 5
w = zeros(1,759);
%uniform distribution to start
for i = 1 : size(w,2)
    w(i) = 1/759;
end

[V,~] = eigs(M',1);
u1 = V(:,1); %first column
u1sum = sum(u1); %get sum

T = t_values(iter);
for t = 1 : T
    w = w * M;
    if(iter==5) % only care if T=1000
        %wt = (w - u1')/u1sum;
        wt = w - (u1'/u1sum);
        winfinite(t) = norm(wt,1);
    end
end

[~, I] = sort(w,'descend');

best20{1,iter} = num2str(T);

for b = 2 : 21
    best20(b,iter) = legend(I(b-1));
end

end

figure;
plot(winfinite);
title('W Infinite');
xlabel('Iterations');

disp(best20);

%matrix2latex(best20,'store.txt');