% John Fulgoni
% COMS 4721 Homework 2
% Problem 3C - Multiclass Logistic Regression

clc;
clear;
close all;

load('mnist_mat.mat');

%% shift matrix and initialize
fivek = ones(1,5000);
five = ones(1,500);

Xtrain21 = [Xtrain;fivek];
Xtest21 = [Xtest;five];

wc = zeros(21,10);

p = 0.1/5000;

c_mlr = zeros(10);


l_0 = [];
l_1 = [];
l_2 = [];
l_3 = [];
l_4 = [];
l_5 = [];
l_6 = [];
l_7 = [];
l_8 = [];
l_9 = [];

%% For loop with call to Gradient
for iter = 1 : 1000
    [dwc, likelihood] = h2_gradient_alt(Xtrain21,label_train,wc);
    wc = wc + (p * dwc);
    disp(iter);
    
    %disp(wc(:,1));
    % likelihood
    l_0 = union(l_0,likelihood(1));
    l_1 = union(l_1,likelihood(2));
    l_2 = union(l_2,likelihood(3));
    l_3 = union(l_3,likelihood(4));
    l_4 = union(l_4,likelihood(5));
    l_5 = union(l_5,likelihood(6));
    l_6 = union(l_6,likelihood(7));
    l_7 = union(l_7,likelihood(8));
    l_8 = union(l_8,likelihood(9));
    l_9 = union(l_9,likelihood(10));
end


%% Plotting Likelihood by iteration
figure
subplot(5,2,1);
plot(l_0);
title('Class 0');
subplot(5,2,2);
plot(l_1);
title('Class 1');
subplot(5,2,3);
plot(l_2);
title('Class 2');
subplot(5,2,4);
plot(l_3);
title('Class 3');
subplot(5,2,5);
plot(l_4);
title('Class 4');
subplot(5,2,6);
plot(l_5);
title('Class 5');
subplot(5,2,7);
plot(l_6);
title('Class 6');
subplot(5,2,8);
plot(l_7);
title('Class 7');
subplot(5,2,9);
plot(l_8);
title('Class 8');
subplot(5,2,10);
plot(l_9);
title('Class 9');

%% Discriminate?

incorrect = {};
count = 1;
yp = 0;

% incorrect examples
in_a = zeros(10,1);
in_b = zeros(10,1);
in_c = zeros(10,1);

a_ind = 20;
b_ind = 304;
c_ind = 395;

for n = 1 : size(Xtest21,2)
    wj = 0;
    pic = Xtest21(:,n);
    
    for j = 1 : 10
        wj = wj + exp(pic' * wc(:,j));
    end
    
    for k = 1 : 10 
        if k == 1
            kmax = (pic' * wc(:,k)) - log(wj);
            yp = k;
            
            % to get spreads for incorrect images
            if n == a_ind
                in_a(k) = kmax;
            end
            if n == b_ind
                in_b(k) = kmax;
            end
            if n == c_ind
                in_c(k) = kmax;
            end
        else
            kq = (pic' * wc(:,k)) - log(wj);
            %to get spreads for incorrect images
            if n == a_ind
                in_a(k) = kq;
            end
            if n == b_ind
                in_b(k) = kq;
            end
            if n == c_ind
                in_c(k) = kq;
            end
            
            %resume
            if kq > kmax
                kmax = kq;
                yp = k;
            end
        end
    end
    
    yt = label_test(n) + 1;
    c_mlr(yt,yp) = c_mlr(yt,yp) + 1;
    
    if yt ~= yp
      incorrect{count,1} = n;
      incorrect{count,2} = yt - 1; % true class
      incorrect{count,3} = yp - 1; % true class
      count = count + 1;
   end
end


%% Table of Accuracy

names = {'Zero';'One';'Two';'Three';'Four';'Five';'Six';'Seven';'Eight'...
    ;'Nine'};
varnames = {'Zero';'One';'Two';'Three';'Four';'Five';'Six';'Seven';...
    'Eight';'Nine'};
T = array2table(c_mlr,'RowNames',names,'VariableNames',varnames);
disp('Confusion Matrix for Bayes Classifier');
disp(T);
% accuracy
a_mlr = 0;
for a = 1 : 10
    a_mlr = a_mlr + c_mlr(a,a);
end
a_mlr = a_mlr / 500


%% Print Incorrect

numbers = [0;1;2;3;4;5;6;7;8;9];
figure

y = Q * Xtest(:,a_ind);
subplot(3,2,1);
imshow(reshape(y,28,28)); 
title('0 ---> 6');

subplot(3,2,2);
bar(numbers, in_a ,'r');
title('Likelihood for each Class');
xlabel('Class');
ylabel('Likelihood');

y = Q * Xtest(:,b_ind);
subplot(3,2,3);
imshow(reshape(y,28,28)); 
title('6 ---> 2');

subplot(3,2,4);
bar(numbers, in_b ,'r');
title('Likelihood for each Class');
xlabel('Class');
ylabel('Likelihood');

y = Q * Xtest(:,c_ind);
subplot(3,2,5);
imshow(reshape(y,28,28)); 
title('7 ---> 4');

subplot(3,2,6);
bar(numbers, in_c ,'r');
title('Likelihood for each Class');
xlabel('Class');
ylabel('Likelihood');