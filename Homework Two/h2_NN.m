% John Fulgoni
% COMS 4721 Homework 2
% Problem 3A - Nearest Neighbor

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

%
%% K = 1

% Nearest Neighbor --> K = 1

% makes a matrix of nxn of all 0
c_nn1 = zeros(10);

incorrect1 = {};
count = 1;
% k = 1
disp('Running Loop k = 1');
for i = 1 : size(Xtest,2)
    U = Xtest(:,i); % one column of testing data
    for j = 1 : size(Xtrain,2)
        V = Xtrain(:,j);
        D = norm(U - V); % finds euclidean distance of a vector
        if j == 1
            min = D;
            minIndex = 1;
        end
        if D < min
            min = D;
            minIndex = j;
            %disp(D);
        end
    end
    % subscript can't be 0!
    % numbers instead have to be 1 to 10 instead of 0 to 9
    yp = label_train(minIndex) + 1;
    yt = label_test(i) + 1;
    
    c_nn1(yt,yp) = c_nn1(yt,yp) + 1;
    
    if yt ~= yp
        incorrect1{count,1} = i;
        incorrect1{count,2} = minIndex;
        count = count + 1;
    end
end

a_nn1 = 0;
for k = 1 : 10
    a_nn1 = a_nn1 + c_nn1(k,k);
end
a_nn1 = a_nn1 / 500

disp('done k = 1');

%% K = 2

% now we have to find two lowest mins, then choose one to base it off of
c_nn2 = zeros(10);

% k = 2
disp('Running Loop k = 2');
for i = 1 : size(Xtest,2)
    U = Xtest(:,i); % one column of testing data
    for j = 1 : size(Xtrain,2)
        V = Xtrain(:,j);
        D = norm(U - V); % finds euclidean distance of a vector
        if j == 1
            min = D;
            min2 = D;
            minIndex = 1;
            minIndex2 = 1;
        end
        if D < min2
            min2 = D;
            minIndex2 = j;
        end
        if D < min
            min2 = min;
            minIndex2 = minIndex;
            min = D;
            minIndex = j;
        end
    end
    % subscript can't be 0!
    % numbers instead have to be 1 to 10 instead of 0 to 9
    val1 = label_train(minIndex);
    val2 = label_train(minIndex2);
    yp = mode([val1 val2]) + 1;

    yt = label_test(i) + 1;
    
    c_nn2(yt,yp) = c_nn2(yt,yp) + 1;
end

a_nn2 = 0;
for k = 1 : 10
    a_nn2 = a_nn2 + c_nn2(k,k);
end
a_nn2 = a_nn2 / 500

disp('done k = 2');

%% K = 3


c_nn3 = zeros(10);

incorrect3 = {};
count = 1;
% k = 3
disp('Running Loop k = 3');
for i = 1 : size(Xtest,2)
    U = Xtest(:,i); % one column of testing data
    for j = 1 : size(Xtrain,2)
        V = Xtrain(:,j);
        D = norm(U - V); % finds euclidean distance of a vector
        if j == 1
            min = D;
            min2 = D;
            min3 = D;
            minIndex = 1;
            minIndex2 = 1;
            minIndex3 = 1;
        end
        if D < min3
            min3 = D;
            minIndex3 = j;
        end
        if D < min2
            min3 = min2;
            minIndex3 = minIndex2;
            min2 = D;
            minIndex2 = j;
        end
        if D < min
            min2 = min;
            minIndex2 = minIndex;
            min = D;
            minIndex = j;
        end
    end
    % subscript can't be 0!
    % numbers instead have to be 1 to 10 instead of 0 to 9
    val1 = label_train(minIndex);
    val2 = label_train(minIndex2);
    val3 = label_train(minIndex3);
    yp = mode([val1 val2 val3]) + 1;

    yt = label_test(i) + 1;
    
    c_nn3(yt,yp) = c_nn3(yt,yp) + 1;
    
    if yt ~= yp
        incorrect3{count,1} = i;
        if label_train(minIndex3) + 1 == yp
            incorrect3{count,2} = minIndex3;
        end
        if label_train(minIndex2) + 1 == yp
            incorrect3{count,2} = minIndex2;
        end
        if label_train(minIndex) + 1 == yp
            incorrect3{count,2} = minIndex;
        end
        count = count + 1;
    end
end

a_nn3 = 0;
for k = 1 : 10
    a_nn3 = a_nn3 + c_nn3(k,k);
end
a_nn3 = a_nn3 / 500

disp('done k = 3');

%% K = 4

c_nn4 = zeros(10);

% k = 4
disp('Running Loop k = 4');
for i = 1 : size(Xtest,2)
    U = Xtest(:,i); % one column of testing data
    for j = 1 : size(Xtrain,2)
        V = Xtrain(:,j);
        D = norm(U - V); % finds euclidean distance of a vector
        if j == 1 % set up initially
            min = D;
            min2 = D;
            min3 = D;
            min4 = D;
            minIndex = 1;
            minIndex2 = 1;
            minIndex3 = 1;
            minIndex4 = 1;
        end
        if D < min4
            min4 = D;
            minIndex4 = j;
        end
        if D < min3
            min4 = min3;
            minIndex4 = minIndex3;
            min3 = D;
            minIndex3 = j;
        end
        if D < min2
            min3 = min2;
            minIndex3 = minIndex2;
            min2 = D;
            minIndex2 = j;
        end
        if D < min
            min2 = min;
            minIndex2 = minIndex;
            min = D;
            minIndex = j;
        end
    end
    % subscript can't be 0!
    % numbers instead have to be 1 to 10 instead of 0 to 9
    val1 = label_train(minIndex);
    val2 = label_train(minIndex2);
    val3 = label_train(minIndex3);
    val4 = label_train(minIndex4);
    yp = mode([val1 val2 val3 val4]) + 1;

    yt = label_test(i) + 1;
    
    c_nn4(yt,yp) = c_nn4(yt,yp) + 1;
end

a_nn4 = 0;
for k = 1 : 10
    a_nn4 = a_nn4 + c_nn4(k,k);
end
a_nn4 = a_nn4 / 500

disp('done k = 4');

%% K = 5

c_nn5 = zeros(10);

incorrect5 = {};
count = 1;
% k = 5
disp('Running Loop k = 5');
for i = 1 : size(Xtest,2)
    U = Xtest(:,i); % one column of testing data
    for j = 1 : size(Xtrain,2)
        V = Xtrain(:,j);
        D = norm(U - V); % finds euclidean distance of a vector
        if j == 1 % set up initially
            min = D;
            min2 = D;
            min3 = D;
            min4 = D;
            min5 = D;
            minIndex = 1;
            minIndex2 = 1;
            minIndex3 = 1;
            minIndex4 = 1;
            minIndex5 = 1;
        end
        if D < min5
            min5 = D;
            minIndex5 = j;
        end
        if D < min4
            min5 = min4;
            minIndex5 = minIndex4;
            min4 = D;
            minIndex4 = j;
        end
        if D < min3
            min4 = min3;
            minIndex4 = minIndex3;
            min3 = D;
            minIndex3 = j;
        end
        if D < min2
            min3 = min2;
            minIndex3 = minIndex2;
            min2 = D;
            minIndex2 = j;
        end
        if D < min
            min2 = min;
            minIndex2 = minIndex;
            min = D;
            minIndex = j;
        end
    end
    % subscript can't be 0!
    % numbers instead have to be 1 to 10 instead of 0 to 9
    val1 = label_train(minIndex);
    val2 = label_train(minIndex2);
    val3 = label_train(minIndex3);
    val4 = label_train(minIndex4);
    val5 = label_train(minIndex5);
    yp = mode([val1 val2 val3 val4 val5]) + 1;

    yt = label_test(i) + 1;
    
    c_nn5(yt,yp) = c_nn5(yt,yp) + 1;
    
    if yt ~= yp
        incorrect5{count,1} = i;
        if label_train(minIndex5) + 1 == yp
            incorrect5{count,2} = minIndex5;
        end
        if label_train(minIndex4) + 1 == yp
            incorrect5{count,2} = minIndex4;
        end
        if label_train(minIndex3) + 1 == yp
            incorrect5{count,2} = minIndex3;
        end
        if label_train(minIndex2) + 1== yp
            incorrect5{count,2} = minIndex2;
        end
        if label_train(minIndex) + 1 == yp
            incorrect5{count,2} = minIndex;
        end
        count = count + 1;
    end
end

a_nn5 = 0;
for k = 1 : 10
    a_nn5 = a_nn5 + c_nn5(k,k);
end
a_nn5 = a_nn5 / 500

disp('done k = 5');

%% Print Table of Accuracy

Accuracy = [a_nn1; a_nn2; a_nn3; a_nn4; a_nn5];
names = {'K = 1';'K = 2';'K = 3';'K = 4';'K = 5'};
T = table(Accuracy,'RowNames',names);
disp('Accuracy for Each K');
disp(T);
%figure
%plot([1;2;3;4;5],Accuracy,'-o');
%ylim([.92 .96]);


%% Images K = 1

close all;
% k = 1;

r = randi(size(incorrect1,1),1,3);

test = incorrect1{r(1),1};
pred = incorrect1{r(1),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
figure
subplot(3,2,1);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Name', 'Wrongly Classified K = 1');

y = Q * Xtrain(:,pred);
subplot(3,2,2);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

% second set

test = incorrect1{r(2),1};
pred = incorrect1{r(2),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
subplot(3,2,3);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));

y = Q * Xtrain(:,pred);
subplot(3,2,4);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

% third set

test = incorrect1{r(3),1};
pred = incorrect1{r(3),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
subplot(3,2,5);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));

y = Q * Xtrain(:,pred);
subplot(3,2,6);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

%% Images K = 3


% k = 1;

r = randi(size(incorrect3,1),1,3);

test = incorrect3{r(1),1};
pred = incorrect3{r(1),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
figure
subplot(3,2,1);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Name', 'Wrongly Classified K = 3');

y = Q * Xtrain(:,pred);
subplot(3,2,2);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

% second set

test = incorrect3{r(2),1};
pred = incorrect3{r(2),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
subplot(3,2,3);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));

y = Q * Xtrain(:,pred);
subplot(3,2,4);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

% third set

test = incorrect3{r(3),1};
pred = incorrect3{r(3),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
subplot(3,2,5);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));

y = Q * Xtrain(:,pred);
subplot(3,2,6);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

%% Images K = 5

% k = 5;

r = randi(size(incorrect5,1),1,3);

test = incorrect5{r(1),1};
pred = incorrect5{r(1),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
figure
subplot(3,2,1);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Name', 'Wrongly Classified K = 5');

y = Q * Xtrain(:,pred);
subplot(3,2,2);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

% second set

test = incorrect5{r(2),1};
pred = incorrect5{r(2),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
subplot(3,2,3);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));

y = Q * Xtrain(:,pred);
subplot(3,2,4);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));

% third set

test = incorrect5{r(3),1};
pred = incorrect5{r(3),2};

% string versions for title
tests = num2str(label_test(test));
preds = num2str(label_train(pred));

y = Q * Xtest(:,test);
subplot(3,2,5);
imshow(reshape(y,28,28));
title(strcat('Test - Class:',tests));

y = Q * Xtrain(:,pred);
subplot(3,2,6);
imshow(reshape(y,28,28));
title(strcat('Nearest Neighbor - Class: ',preds));