% John Fulgoni
% Homework 5
% Problem 5 Part 2 New York Times

clc;
clear;
close all;

load('nyt_data.mat');

rank = 25;
iter = 200;

%% Initialize

W = zeros(size(nyt_vocab,1),rank);
H = zeros(rank,size(Xcnt,2));
X = zeros(3012,8447); %3012 words, 8447 documents
%{
for i = 1 : size(W,1)
    for j = 1 : size(W,2)
        W(i,j) = rand;
        if(W(i,j)==0)
            W(i,j) = 0.000001;
        end
    end
end
for i = 1 : size(H,1)
    for j = 1 : size(H,2)
        H(i,j) = rand;
        if(H(i,j)==0)
            H(i,j) = 0.000001;
        end
    end
end

for d = 1 : size(Xcnt,2)
    id = Xid{d};
    cnt = Xcnt{d};
    for i = 1 : size(id,2)
        X(id(i),d) = cnt(i);
    end
end

%% NMF with Divergence

diverge_all = zeros(iter,1);

for s = 1 : iter
    disp(s);
    purple = X./((W*H) + 10^-16);
    
    %normalize pink
    red = W';
    pink = zeros(25,3012);
    for row = 1 : size(red,1)
        sum_row = sum(red(row,:));
        pink(row,:) = red(row,:)/sum_row;
    end
    H = H .* (pink * purple);
    
    %normalize robin
    blue = H';
    robin = zeros(8447,25);
    for col = 1 : size(blue,2)
        sum_col = sum(blue(:,col));
        robin(:,col) = blue(:,col)/sum_col;
    end
    
    %do I update purple too?
    purple = X./((W*H) + 10^-16);
    W = W .* (purple * robin);
    
    %this takes extremely long - is there a faster way?
    %{
    diverge = 0;
    for i = 1 : size(X,1)
        for j = 1 : size(X,2)
            WH = (W*H) + 10^-16;
            
            WHij = WH(i,j);
            diverge = diverge + (X(i,j)*log(1/WHij)) + WHij;
        end
    end
    
    diverge_all(s) = diverge;
    %}
    WH = (W*H) + 10^-16;
    divergence = X.*log(1./WH) + WH;
    diverge_all(s) = sum(divergence(:));
end


%% Plot
figure;
plot(diverge_all);
title('Divergence');
xlabel('iterations');
ylabel('divergence penalty');
%}
%% Normalize columns of W
%save('timesdone.mat','W','H');
load('timesdone.mat');

for row = 1 : size(W,1)
    sum_w = sum(W(row,:));
    W(row,:) = W(row,:)/(sum_w + 10^-16);
end

columns = [3,15,16,20,23];
word_groups = cell(10,5);

for i = 1 : 5
    col1 = W(:,columns(i));
    [~,word] = sort(col1,'descend');
    for b = 1 : 10
        %disp(prob(b));
        word_groups{b,i} = nyt_vocab{word(b)};
    end
end

disp(word_groups);

matrix2latex(word_groups,'store.txt');