% John Fulgoni
% COMS 4721
% Homework 3
% Part 2 - Bayes Classifier with Shared Covariance

clc;
clear;
close all;

load('cancer.mat');

%% Cut the Data and initialize

labeltest = label(1,1:183);
Xtest = X(:,1:183);

labeltrain = label(:,184:end);
Xtrain = X(:,184:end);


n = 500;
T = 1000;

wt = zeros(n,1);

epsilon_t = zeros(T,1);
alpha_t = zeros(T,1);

training_sums = zeros(T,size(Xtrain,2));
training_accuracy = zeros(1,T);


test_sums = zeros(T,size(Xtest,2));
testing_accuracy = zeros(1,T);

% just for the first iteration
for i = 1 : n
    wt(i) = (1/n);
end

% indices to plot w values over time
a_index = 168;
b_index = 245;
c_index = 347;

wt_a = zeros(T+1,1);
wt_b = zeros(T+1,1);
wt_c = zeros(T+1,1);

wt_a(1) = wt(a_index);
wt_b(1) = wt(b_index);
wt_c(1) = wt(c_index);

%% Loop for T iterations
for t = 1 : T

    disp(t);
    
%% Bootstrap Set

cvect = pick_vars(wt,n); % same bootstrapped set
%disp(wt(1));

Bt = zeros(10,500);
Blabel = zeros(1,500);

for i = 1 : n
    Bt(:,i) = Xtrain(:,cvect(i));
    Blabel(i) = labeltrain(cvect(i));
end


%% Call to Bayes Classifer

aug_w = bayes_classifier(Bt, Blabel);


%% Get Epsilon and Alpha
% at this point, never use the bootstrapped set!

epsilon = 0;

for i = 1 : size(Xtrain,2)
    entry_train = Xtrain(:,i);
    
    ftxi = sign((entry_train' * aug_w)); % predicted answer
    %disp(i);disp('ftxi'); disp(ftxi);
    %yi = labeltrain(i); % correct answer
    by = labeltrain(i);
    %disp('yi');disp(yi);
    
    %ci_index = cvect(i);
    
    if(ftxi ~= by)
        epsilon = epsilon + wt(i);
        %epsilon = epsilon + wt(ci_index);
    end
end
%disp(epsilon);
alpha = (1/2) * log ((1-epsilon)/epsilon);

epsilon_t(t) = epsilon; % store for later to plot
alpha_t(t) = alpha;  % store for later to plot

%% Update wt

for k = 1 : size(Xtrain,2)
    entryw = Xtrain(:,k);
    %ftxi = sign(w0 + (entry'*aug_w)); % predicted answer
    ftw = sign(entryw' * aug_w); % predicted answer
    yiw = labeltrain(k); % correct answer
    
    %c_index = cvect(k);
    % if we're right, then yi and ftxi will be the same sign
    % and the exp term will be to the negative, which means it'll have
    % a smaller influence
    
    % if we're wrong, then yi and ftxi will be the opposite sign
    % which means the exp term will be positive
    % and it'll have a bigger influence

    expterm = -1 * alpha * yiw * ftw;
    %disp(expterm);
    
    wt(k) = wt(k) * exp(expterm); % NEED THE EXP HERE GENIUS
    %wt(c_index) = wt(c_index) * exp(expterm);
    
    
end
wt = wt ./ sum(wt); % normalize wt

wt_a(t+1) = wt(a_index);
wt_b(t+1) = wt(b_index);
wt_c(t+1) = wt(c_index);
%disp('Wt Sum');
%disp(sum(wt)); % should always be 1

%% Training Data

training_results = zeros(1,size(Xtrain,2));

for i = 1 : size(Xtrain,2)
    entry = Xtrain(:,i);
    ft = sign(entry'*aug_w); % predicted answer
    
    if(t == 1)
        training_sums(t,i) = alpha * ft;
    else
        training_sums(t,i) = alpha * ft + training_sums(t-1,i);
    end
    
    training_results(i) = sign(training_sums(t,i));
end

for i = 1 : size(Xtrain,2)
    if(labeltrain(i) == training_results(i))
        training_accuracy(t) = training_accuracy(t) + 1;
    end
end

% need to sum up here for each iteration

%% Testing data
test_results = zeros(1,size(Xtest,2));

for i = 1 : size(Xtest,2)
    entry = Xtest(:,i);
    %ftxi = sign(w0 + (entry'*aug_w)); % predicted answer
    ft = sign(entry'*aug_w); % predicted answer

    if(t == 1)
        test_sums(t,i) = alpha * ft;
    else
        test_sums(t,i) = (alpha * ft) + test_sums(t-1,i);
    end
    
    test_results(i) = sign(test_sums(t,i));
end

for i = 1 : size(Xtest,2)
    if(labeltest(i) == test_results(i))
        testing_accuracy(t) = testing_accuracy(t) + 1;
    end
end
%% end loop 
%}

end % end t

%disp('Epsilon T');
%disp(epsilon_t);

%% Bayes Classifier on Training and Testing Set Without Boosting
% 84% correct

w_bayes = bayes_classifier(Xtrain,labeltrain);

bayes_right = 0;
for i = 1 : size(Xtest,2)
    entry = Xtest(:,i);
    
    ftxi = sign((entry'*w_bayes)); % predicted answer
    yi = labeltest(i); % correct answer
    
    if(ftxi == yi)
        bayes_right = bayes_right + 1;
    end
end
bayes_accuracy = bayes_right / size(Xtest,2);
disp('Bayes Accuracy');
disp(bayes_accuracy);
%}

training_accuracy = training_accuracy / size(Xtrain,2);
testing_accuracy = testing_accuracy / size(Xtest,2);

%% Plot Stuff

disp('Training Accuracy');
disp(training_accuracy(t));
disp('Testing Accuracy');
disp(testing_accuracy(t));


figure
plot(training_accuracy);
hold on;
plot(testing_accuracy);
legend('Training Accuracy','Testing Accuracy');
xlabel('T iterations');
ylabel('Accuracy Percentage');
title('Accuracy of Training and Testing Predictions - Bayes Classifier');

figure
plot(epsilon_t);
hold on;
plot(alpha_t);
legend('Epsilon','Alpha');
title('Epsilon and Alpha over T iterations - Bayes Classifier');
xlabel('T iterations');

figure
plot(wt_a);
hold on;
plot(wt_b);
hold on;
plot(wt_c);
stringA = strcat('Index A--',num2str(a_index));
stringB = strcat('Index B--',num2str(b_index));
stringC = strcat('Index C--',num2str(c_index));
legend(stringA, stringB, stringC);
title('Wt Values for Three Indices - Bayes Classifier');
xlabel('T iterations');