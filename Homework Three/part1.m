% John Fulgoni
% COMS 4721
% Homework 3
% Part 1 Plots

clc;
clear;
close all;

%load('cancer.mat');

w = [0.1;0.2;0.3;0.4];

n = 100;

% in this scenario, results are the sample vector c
figure
for i = 1 : 5
    results = pick_vars(w,(n*i));
    subplot(3,2,i);
    histogram(results);
    title(strcat('n = ',num2str(i*100)));
end
