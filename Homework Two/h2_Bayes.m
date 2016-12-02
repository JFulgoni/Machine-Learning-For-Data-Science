% John Fulgoni
% COMS 4721 Homework 2
% Problem 3B - Bayes Classifer

clc;
clear;
close all;

load('mnist_mat.mat');

% each column is an image


%% To show an image

%y = Q * Xtest(:,350);
%figure
%imshow(reshape(y,28,28));
% the image most of the time needs to be rotated and/or flipped

%% Bayes Mean of Class

c_bb = zeros(10);

%count_class = zeros(1,10);

class_sums = zeros(20,10); % column is a class

% for each class, do we want the gaussian distribution of the value of each
% pixel?
% like we take the average value of each pixel of the class we know, then
% find the maximum likelihood for each testing image?

for i = 1 : size(Xtrain,2)
    class = label_train(i) + 1; % +1 for indices
    %count_class(class) = count_class(class) + 1;
    % They're each 500...
    
    for k = 1: size(Xtrain,1)
        class_sums(k,class) = class_sums(k,class) + Xtrain(k,i);  
    end
     
end
%disp(class_sums);
class_mu = class_sums./500; % finding the gaussian mean of all the classes
%disp(class_avg);

% each column in mu is a class
%% Covariance Matrix

cov_1 = zeros(20);
cov_2 = zeros(20);
cov_3 = zeros(20);
cov_4 = zeros(20);
cov_5 = zeros(20);
cov_6 = zeros(20);
cov_7 = zeros(20);
cov_8 = zeros(20);
cov_9 = zeros(20);
cov_10 = zeros(20);

% need one cov for each class
for i = 1 : size(Xtrain,2)
    % get the class
    class = label_train(i) + 1; % +1 for indices
    
    %need one covariance for each case
    %find each term minues the average for the case
    
    switch class
        case 1
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,1);
                cc = c * c';
                cov_1 = cov_1 + cc;      
           %end
        case 2
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,2);
                cc = c * c';
                cov_2 = cov_2 + cc;      
            %end
        case 3
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,3);
                cc = c * c';
                cov_3 = cov_3 + cc;      
            %end
        case 4
           % for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,4);
                cc = c * c';
                cov_4 = cov_4 + cc;      
            %end
        case 5
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,5);
                cc = c * c';
                cov_5 = cov_5 + cc;      
            %end
        case 6
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,6);
                cc = c * c';
                cov_6 = cov_6 + cc;      
            %end
        case 7
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,7);
                cc = c * c';
                cov_7 = cov_7 + cc;      
            %end
        case 8
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,8);
                cc = c * c';
                cov_8 = cov_8 + cc;      
            %end
        case 9
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,9);
                cc = c * c';
                cov_9 = cov_9 + cc;      
            %end
        case 10
            %for k = 1 : size(Xtrain,1) % gets each row of Xtrain
                c = Xtrain(:,i) - class_mu(:,10);
                cc = c * c';
                cov_10 = cov_10 + cc;      
            %end
    end % end switch

end % end for

cov_1 = cov_1./500;
cov_2 = cov_2./500;
cov_3 = cov_3./500;
cov_4 = cov_4./500;
cov_5 = cov_5./500;
cov_6 = cov_6./500;
cov_7 = cov_7./500;
cov_8 = cov_8./500;
cov_9 = cov_9./500;
cov_10 = cov_10./500;

%% Classify Xtest

incorrect = {};
count = 1;

fin_max = 0;
yp = 0;

i_11 = zeros(1,10);
i_357 = zeros(1,10);
i_481 = zeros(1,10);

% loop for all entries

for i = 1 : size(Xtest,2) % each entry out of 500 tests
        c = 1;
        % want to maximize the fin value for each class;

        %first class only c = 1
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_1);
        fin_max = fin;
        if i == 11
            i_11(c) = fin;
        end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        yp = c;
        c = c + 1;
        
        %c = 2
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_2);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 3
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_3);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 4
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_4);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 5
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_5);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 6
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_6);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 7
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_7);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 8
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_8);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 9
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_9);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
         if i == 11
            i_11(c) = fin;
         end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        c = c + 1;
        
        %c = 10
        fin = bayes(Xtest(:,i),class_mu(:,c),cov_10);
        %from c = 2 onward copy below:
         if fin > fin_max
               fin_max = fin;
               yp = c;
         end
        if i == 11
            i_11(c) = fin;
        end
        if i == 357
            i_357(c) = fin;
        end
        if i == 481
            i_481(c) = fin;
        end
        yt = label_test(i) + 1;
        
        %yt
        %yp
        
        c_bb(yt,yp) = c_bb(yt,yp) + 1;
        
        % gets a list of incorrect indices
        if yt ~= yp
            incorrect{count,1} = i;
            incorrect{count,2} = yt;
            incorrect{count,3} = yp;
            count = count + 1;
        end
        
    % for images, need to find the distribution for 3 incorrect
end % end i
%}

%% Table of Confusion Matrix

names = {'Zero';'One';'Two';'Three';'Four';'Five';'Six';'Seven';'Eight'...
    ;'Nine'};
varnames = {'Zero';'One';'Two';'Three';'Four';'Five';'Six';'Seven';...
    'Eight';'Nine'};
T = array2table(c_bb,'RowNames',names,'VariableNames',varnames);
disp('Confusion Matrix for Bayes Classifier');
disp(T);
% accuracy
a_bb = 0;
for a = 1 : 10
    a_bb = a_bb + c_bb(a,a);
end
a_bb = a_bb / 500

%% Average Image
figure
for p = 1 : 10
    y = Q * class_mu(:,p);
    subplot(5,2,p);
    imshow(reshape(y,28,28));
    titl = strcat('Average Image for Class=',int2str(p-1));
    title(titl);
end
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%set(gcf, 'Name', 'Images Based on Average Pixels');

%% Incorrect Assignments and their Gaussians

numbers = [0;1;2;3;4;5;6;7;8;9];
figure
% wrong index #11
index = incorrect{1,1};
qp = incorrect{1,2};
qt = incorrect{1,3};
y = Q * Xtest(:,index);
subplot(3,2,1);
imshow(reshape(y,28,28)); 
titl = strcat(int2str(qp-1),'-->',int2str(qt-1));
title(titl);

subplot(3,2,2);
bar(numbers, i_11 ,'r');
title('Likelihood for each Class');
xlabel('Class');
ylabel('Likelihood');

%wrong index #357
index = incorrect{23,1};
qp = incorrect{23,2};
qt = incorrect{23,3};
y = Q * Xtest(:,index);
subplot(3,2,3);
imshow(reshape(y,28,28)); 
titl = strcat(int2str(qp-1),'-->',int2str(qt-1));
title(titl);

subplot(3,2,4);
bar(numbers, i_357 ,'r');
title('Likelihood for each Class');
xlabel('Class');
ylabel('Likelihood');

% wrong index #481
index = incorrect{32,1};
qp = incorrect{32,2};
qt = incorrect{32,3};
y = Q * Xtest(:,index);
subplot(3,2,5);
imshow(reshape(y,28,28)); 
titl = strcat(int2str(qp-1),'-->',int2str(qt-1));
title(titl);

subplot(3,2,6);
bar(numbers, i_481 ,'r');
title('Likelihood for each Class');
xlabel('Class');
ylabel('Likelihood');