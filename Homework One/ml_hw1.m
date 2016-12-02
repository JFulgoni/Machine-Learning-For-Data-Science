%John Fulgoni
%Homework 1
%COMS 4721 - Machine Learning for Data Science
%Due 10 Feburary 2015


%% Part One
clc;
clear;
close all;
load('data.mat');

warning('off','MATLAB:nearlySingularMatrix');

%for part 2, need to run this 1000 times, and get the mean for each time
MAE = [];
for m = 1:1000

[testing,indext] = datasample(X,20,1,'Replace',false); % gets 20 lines randomly
%disp(testing);
[training, index] = setdiff(X,testing,'rows'); % difference from X and random sample
%[training, index] = setxor(X,testing,'rows'); % difference from X and random sample
% disp(index);
y_training = y(index,:);
y_testing = y(indext,:);

%least squares solution of wls = (XtX)^-1Xty
wls = (training'*training)\(training'*y_training);

if(m == 1)
    disp('Part One - A');
    disp('wls');
    disp(wls);
    fprintf('Each of the signs has a corresponding meaning for the legend:\n\n');
    fprintf('Number of Cylinders (-) The more cylinders, the fewer MPG\n');
    fprintf('Displacement (+) Higher displacement, the better MPG\n');
    fprintf('Horsepower (-) Higher horsepower, the worse MPG\n');
    fprintf('Weight (-) Higher weight, the worse MPG\n');
    fprintf('Acceleration (+) Better acceleration, the better MPG\n');
    fprintf('Model Year (+) The newer model year, the better MPG\n\n');
%need to explain what each of these numbers mean in relation to the
%input data, assuming it's correct (which I think it should be)
end

%can use this somehow to make ynew
%Slides say it's Xnew * wls --> which I think is test * wls

ynew = testing*wls;
%this returns a vector of 20 numbers, but is that right?
%do we want a 20x7 to match testing 20x7?

diff_vect = [];

for n = 1:20
    A = y_testing(n);
    B = ynew(n);
    C = abs(A - B);
    diff_vect =union(diff_vect, C);
    %union might reorder things, because that shouldn't
end
diff_vect = diff_vect'; %converts it to a vector

MAE_n = mean(diff_vect);
%disp(MAE_n);
MAE = union(MAE,MAE_n);


end %end for m 1:1000

disp('Part One - B');
MAE = MAE'; %converts it to a vector
MAE_mean = mean(MAE);
disp('MAE_mean:');
disp(MAE_mean);
MAE_std = std(MAE);
disp('MAE_std:');
disp(MAE_std);

%% Part Two - P=1

MAE = [];
RMSE = [];
p1errors = [];

for m = 1:1000

[testing,indext] = datasample(X,20,1,'Replace',false); %gets 20 lines randomly
%disp(testing);
[training, index] = setdiff(X,testing,'rows'); %difference from X and random sample
%[training, index] = setxor(X,testing,'rows'); %difference from X and random sample
%disp(index);
y_training = y(index,:);
y_testing = y(indext,:);

%least squares solution of wls = (XtX)^-1Xty
wls = (training'*training)\(training'*y_training);

%can use this somehow to make ynew
%Slides say it's Xnew * wls --> which I think is test * wls

ynew = testing*wls;
%this returns a vector of 20 numbers, but is that right?
%do we want a 20x7 to match testing 20x7?

diff_vect = [];
for n = 1:20
    A = y_testing(n);
    B = ynew(n);
    C = A - B;
    p1errors = union(p1errors,C);
    %square this for mean squared error
    C = C^2; 
    diff_vect =union(diff_vect, C);
end
diff_vect = diff_vect'; %converts it to a vector

MAE_n = sum(diff_vect)/20;
MAE_mean = mean(MAE_n); %finds the mean of all squared elements of MAE
MAE_sqrt = sqrt(MAE_mean); %square roots the mean MAE
RMSE = union(RMSE,MAE_sqrt);

end %end for m 1:1000

disp('Part Two - A - P=1');
RMSE = RMSE'; %converts it to a vector
RMSE_mean1 = mean(RMSE);
disp('RMSE_mean1:');
disp(RMSE_mean1);
RMSE_std1 = std(RMSE);
disp('RMSE_std1:');
disp(RMSE_std1);

%% Part Two - P=2

MAE = [];
RMSE = [];
p2errors = [];

%Processes P=2
p2 = X(:,2:7); %gets all rows with columns 2 to 7
%disp('p2(1)');
%disp(p2(1,:));
p2_s = p2.^2;
%disp('p2_s(1)^2');
%disp(p2_s(1,:));
p2_union = [X p2_s];
%disp('p2_union');
%disp(p2_union(1,:));

for m = 1:1000

[testing,indext] = datasample(X,20,1,'Replace',false); %gets 20 lines randomly
%disp(testing);
[training, index] = setdiff(X,testing,'rows'); %difference from X and random sample
%[training, index] = setxor(X,testing,'rows'); %difference from X and random sample
%disp(index);
y_training = y(index,:);
y_testing = y(indext,:);

%least squares solution of wls = (XtX)^-1Xty
wls = (training'*training)\(training'*y_training);

%can use this somehow to make ynew
%Slides say it's Xnew * wls --> which I think is test * wls

ynew = testing*wls;
%this returns a vector of 20 numbers, but is that right?
%do we want a 20x7 to match testing 20x7?

diff_vect = [];
for n = 1:20
    A = y_testing(n);
    B = ynew(n);
    C = A - B;
    p2errors = union(p2errors,C);
    %square this for mean squared error
    C = C^2; 
    diff_vect =union(diff_vect, C);
end
diff_vect = diff_vect'; %converts it to a vector

MAE_n = sum(diff_vect)/20;
MAE_mean = mean(MAE_n); %finds the mean of all squared elements of MAE
MAE_sqrt = sqrt(MAE_mean); %square roots the mean MAE
RMSE = union(RMSE,MAE_sqrt);

end %end for m 1:1000

disp('Part Two - A - P=2');
RMSE = RMSE'; %converts it to a vector
RMSE_mean2 = mean(RMSE);
disp('RMSE_mean2:');
disp(RMSE_mean2);
RMSE_std2 = std(RMSE);
disp('RMSE_std2:');
disp(RMSE_std2);

%% Part Two - P=3

MAE = [];
RMSE = [];
p3errors = [];

%Processes P=3
p3 = X(:,2:7);
p3_s = p3.^2;
p3_union = [p2_union p3_s];

for m = 1:1000

[testing,indext] = datasample(X,20,1,'Replace',false); %gets 20 lines randomly
%disp(testing);
[training, index] = setdiff(X,testing,'rows'); %difference from X and random sample
%[training, index] = setxor(X,testing,'rows'); %difference from X and random sample
%disp(index);
y_training = y(index,:);
y_testing = y(indext,:);

%least squares solution of wls = (XtX)^-1Xty
%wls = inv(training'*training)*training'*y_training;
wls = (training'*training)\(training'*y_training);

%can use this somehow to make ynew
%Slides say it's Xnew * wls --> which I think is test * wls

ynew = testing*wls;
%this returns a vector of 20 numbers, but is that right?
%do we want a 20x7 to match testing 20x7?

diff_vect = [];
for n = 1:20
    A = y_testing(n);
    B = ynew(n);
    C = A - B;
    p3errors = union(p3errors,C);
    %square this for mean squared error
    C = C^2; 
    diff_vect =union(diff_vect, C);
end
diff_vect = diff_vect'; %converts it to a vector

MAE_n = sum(diff_vect)/20;
MAE_mean = mean(MAE_n); %finds the mean of all squared elements of MAE
MAE_sqrt = sqrt(MAE_mean); %square roots the mean MAE
RMSE = union(RMSE,MAE_sqrt);

end %end for m 1:1000

disp('Part Two - A - P=3');
RMSE = RMSE'; %converts it to a vector
RMSE_mean3 = mean(RMSE);
disp('RMSE_mean3:');
disp(RMSE_mean3);
RMSE_std3 = std(RMSE);
disp('RMSE_std3:');
disp(RMSE_std3);
%% Part Two - P=4

MAE = [];
RMSE = [];
p4errors = [];

%Processes P=4
p4 = X(:,2:7);
p4_s = p4.^2;
p4_union = [p3_union p4_s];

for m = 1:1000

[testing,indext] = datasample(X,20,1,'Replace',false); %gets 20 lines randomly
%disp(testing);
[training, index] = setdiff(X,testing,'rows'); %difference from X and random sample
%[training, index] = setxor(X,testing,'rows'); %difference from X and random sample
%disp(index);
y_training = y(index,:);
y_testing = y(indext,:);

%least squares solution of wls = (XtX)^-1Xty
%wls = inv(training'*training)*training'*y_training;
wls = (training'*training)\(training'*y_training);

%can use this somehow to make ynew
%Slides say it's Xnew * wls --> which I think is test * wls

ynew = testing*wls;
%this returns a vector of 20 numbers, but is that right?
%do we want a 20x7 to match testing 20x7?

diff_vect = [];
for n = 1:20
    A = y_testing(n);
    B = ynew(n);
    C = A - B;
    p4errors = union(p4errors,C);
    %square this for mean squared error
    C = C^2; 
    diff_vect =union(diff_vect, C);
end
diff_vect = diff_vect'; %converts it to a vector

MAE_n = sum(diff_vect)/20;
MAE_mean = mean(MAE_n); %finds the mean of all squared elements of MAE
MAE_sqrt = sqrt(MAE_mean); %square roots the mean MAE
RMSE = union(RMSE,MAE_sqrt);

end %end for m 1:1000

disp('Part Two - A - P=4');
RMSE = RMSE'; %converts it to a vector
RMSE_mean4 = mean(RMSE);
disp('RMSE_mean4:');
disp(RMSE_mean4);
RMSE_std4 = std(RMSE);
disp('RMSE_std4:');
disp(RMSE_std4);
%% Prints Tables and Histogram
close all;

figure
%subplot(2,2,1)
hist(p1errors,50);
xlabel('Dimension P=1');
ylabel('Sum of errors');
title('Errors from Predicted Ynew');
%subplot(2,2,2)
figure
hist(p2errors,50);
xlabel('Dimension P=2');
ylabel('Sum of errors');
title('Errors from Predicted Ynew');
%subplot(2,2,3)
figure
hist(p3errors,50);
xlabel('Dimension P=3');
ylabel('Sum of errors');
title('Errors from Predicted Ynew');
%subplot(2,2,4)
figure
hist(p4errors,50);
xlabel('Dimension P=4');
ylabel('Sum of errors');
title('Errors from Predicted Ynew');
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

R_means = [RMSE_mean1; RMSE_mean2; RMSE_mean3; RMSE_mean4];
R_stds = [RMSE_std1; RMSE_std2; RMSE_std3; RMSE_std4];
names = {'P=1';'P=2';'P=3';'P=4'};
T = table(R_means,R_stds,'RowNames',names);
disp('Part Two - Table');
disp(T);


%% Part 2 - C - Fit a Gaussian Log Likelihood using maximum likelyhood

%Gaussian Mean is the sum from 1 to n of all the data, then divide by n

fprintf('Gaussian Mean is the sum from 1 to n of all the data, then divide by n\n\n');

e1 = sum(p1errors,2);
e2 = sum(p2errors,2);
e3 = sum(p3errors,2);
e4 = sum(p4errors,2);

mu1 = e1/size(p1errors,2);
mu2 = e2/size(p2errors,2);
mu3 = e3/size(p3errors,2);
mu4 = e4/size(p4errors,2);

fprintf('Gaussian Variance is the mean of the sum of each number minus the mean squared\n\n');

p1var = 0;
for n = 1:size(p1errors,2)
    p1var = p1var + (p1errors(n)-mu1)^2;
end
sigma1 = p1var/size(p1errors,2);

p2var = 0;
for n = 1:size(p2errors,2)
    p2var = p2var + (p2errors(n)-mu2)^2;
end
sigma2 = p2var/size(p2errors,2);

p3var = 0;
for n = 1:size(p3errors,2)
    p3var = p3var + (p3errors(n)-mu3)^2;
end
sigma3 = p3var/size(p3errors,2);

p4var = 0;
for n = 1:size(p4errors,2)
    p4var = p4var + (p4errors(n)-mu4)^2;
end
sigma4 = p4var/size(p4errors,2);

Gaussian_Mean = [mu1;mu2;mu3;mu4];
Guassian_Variance = [sigma1;sigma2;sigma3;sigma4];
names = {'P=1';'P=2';'P=3';'P=4'};
Tg = table(Gaussian_Mean,Guassian_Variance,'RowNames',names);
disp(Tg);

%{
loglike1 = 0;
for n = 1:20000
    diff = p1errors(n) - RMSE_mean1;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(RMSE_std1)^2);
    exponent = exp(quotient);
    final = exponent/(RMSE_std1*sqrt(2*pi));
    log_final = log(final);
    loglike1 = loglike1 + log_final;
end

loglike2 = 0;
for n = 1:20000
    diff = p2errors(n) - RMSE_mean2;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(RMSE_std2)^2);
    exponent = exp(quotient);
    final = exponent/(RMSE_std2*sqrt(2*pi));
    log_final = log(final);
    loglike2 = loglike2 + log_final;
end

loglike3 = 0;
for n = 1:20000
    diff = p3errors(n) - RMSE_mean3;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(RMSE_std3)^2);
    exponent = exp(quotient);
    final = exponent/(RMSE_std3*sqrt(2*pi));
    log_final = log(final);
    loglike3 = loglike3 + log_final;
end

loglike4 = 0;
for n = 1:20000
    diff = p4errors(n) - RMSE_mean4;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(RMSE_std4)^2);
    exponent = exp(quotient);
    final = exponent/(RMSE_std4*sqrt(2*pi));
    log_final = log(final);
    loglike4 = loglike4 + log_final;
end

%}

loglike1 = 0;
for n = 1:20000
    diff = p1errors(n) - mu1;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(sigma1)^2);
    exponent = exp(quotient);
    final = exponent/(sigma1*sqrt(2*pi));
    log_final = log(final);
    loglike1 = loglike1 + log_final;
end

loglike2 = 0;
for n = 1:20000
    diff = p2errors(n) - mu2;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(sigma2)^2);
    exponent = exp(quotient);
    final = exponent/(sigma2*sqrt(2*pi));
    log_final = log(final);
    loglike2 = loglike2 + log_final;
end

loglike3 = 0;
for n = 1:20000
    diff = p3errors(n) - mu3;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(sigma3)^2);
    exponent = exp(quotient);
    final = exponent/(sigma3*sqrt(2*pi));
    log_final = log(final);
    loglike3 = loglike3 + log_final;
end

loglike4 = 0;
for n = 1:20000
    diff = p4errors(n) - mu4;
    diff_sq = diff^2;
    quotient = diff_sq/(-2*(sigma4)^2);
    exponent = exp(quotient);
    final = exponent/(sigma4*sqrt(2*pi));
    log_final = log(final);
    loglike4 = loglike4 + log_final;
end

figure
bar([loglike1;loglike2;loglike3;loglike4]);
title('Sum of Log Likelihood for Each P');
xlabel('Dimension of P');
ylabel('Sum of Likelihood');
ylim([-70000 -65000]);


