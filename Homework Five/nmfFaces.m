% John Fulgoni
% Homework 5
% Problem 5 Part 2 Faces

clc;
clear;
close all;

load('faces.mat');

rank = 25;
iter = 200;

%% Initialize

W = zeros(size(X,1),rank);
H = zeros(rank,size(X,2));

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


%% Iterate
% use euclidean penalty
objective = zeros(iter,1);

for i = 1 : iter
    disp(i);
    H = H .* (W' * X) ./ (W' * W * H);
    W = W .* (X * H') ./ (W * H * H');
    objective(i) = norm(X - (W*H));
end

%save('finished.mat','W','H');
% just so you can continue where you left off

%% Plot
figure;
plot(objective);
title('Objective');
xlabel('Iterations');
ylabel('Objective Value');
%}
%% For 3 Images, find the column of W where the weight of H is the heighest
load('finished.mat');

im1 = 500;
image1 = X(:,im1)./255;
h1 = H(:,im1);
[~,ind1] = max(h1);
w1 = W(:,ind1);

im2 = 135;
image2 = X(:,im2)./255;
h2 = H(:,im2);
[~,ind2] = max(h2);
w2 = W(:,ind2);

im3 = 975;
image3 = X(:,im3)./255;
h3 = H(:,im3);
[~,ind3] = max(h3);
w3 = W(:,ind3);

figure;
subplot(3,2,1);
imshow(reshape(image1,32,32));
title('Image 500');
subplot(3,2,2);
imshow(reshape(w1,32,32));
title('W = 18');
subplot(3,2,3);
imshow(reshape(image2,32,32));
title('Image 125');
subplot(3,2,4);
imshow(reshape(w2,32,32));
title('W = 10');
subplot(3,2,5);
imshow(reshape(image3,32,32));
title('Image 975');
subplot(3,2,6);
imshow(reshape(w3,32,32));
title('W = 22');
