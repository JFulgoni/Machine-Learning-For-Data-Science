% Logistic test

% John Fulgoni
% COMS 4721
% Homework 3
% Part 2 - Bayes Classifier Test

clc;
clear;
close all;

load('cancer.mat');

%% Cut the Data and initialize

labeltest = label(1,1:183);
Xtest = X(:,1:183);

labeltrain = label(:,184:end);
Xtrain = X(:,184:end);

omegai = zeros(10,1);

p = 0.1; % step size

%% Classifier

for i = 1 : size(Xtrain,2)
    xi = Xtrain(:,i);
    yi = labeltrain(i);
    
    % w has to be some sort of 1 x 10 vector right?
    expterm = -1 * yi * xi' * omegai;
    
    sigma = 1 / (1 + exp(expterm));
    
    step_term = p * (1 - sigma) * yi * xi;
    
    omegai = omegai + step_term;
end

%% Test Correct
log_correct = 0;
for j = 1 : size(Xtest,2)
    xj = Xtest(:,j);
    yj = labeltest(j);
    
    result = sign(xj' * omegai);
    if(result == yj)
        log_correct = log_correct + 1;
    end
end

log_correct = log_correct / size(Xtest,2);
disp('Logistic Accuracy');
disp(log_correct);