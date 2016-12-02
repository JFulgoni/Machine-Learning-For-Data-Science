% John Fulgoni
% Homework 4
% Problem 2 - Matrix Factorization
% Due 14 April 2015

clc;
clear;
close all;

%% Set variables
load('movie_ratings.mat');

sigma = 0.25;
d = 20; % rank of intermediate matrix
lambda = 10;
I = eye(d);

loi = lambda * sigma * I;
% slide 19 in April 2 notes for MAP ALgorithm

% movie(i).rating(j) is the rating of the movie by user j
% movie(i).user_id(j) is the user who gave rating j
% movie_names(i) is the name of each movie for i

% user(i).rating(j) is the rating given by user i
% user(i).movie_id(j) is the movie that was rated by user i

% omegaui is the set of indexed objects rated by user i
% user(i).movie_id
% omegavj is the set of indexed users who rated object j
% movie(j).user_id

num_users = size(user,2);
num_movies = size(movie,2);

ui = zeros(d,num_users); % d x N1

RMSE_all = zeros(100,1); %to store to plot later
likelihood_all = zeros(100,1); %to store likelihood over time

%% Initialize vj
disp('Initializing Vj');
vj = zeros(d,num_movies); % have to be initialized in some way
% can't just be zeros
% size of d x N2

for i = 1 : size(vj,1)
    for j = 1 : size(vj,2)
        vj(i,j) = normrnd(0,(1/lambda));
        %vj(i,j) = rand;
    end
end

%% Iterate 100 times

for iter = 1 : 100
    disp(iter);
%% Update user location
disp('Updating User Location');

for i = 1 : num_users
%i = 1;
    movies_names = user(i).movie_id; % names of movies rated
    movie_ratings = user(i).rating; %ratings of movies
    
    vj_sum = zeros(20);
    u2term = zeros(20,1); % I think
    
    for j = 1 : size(movies_names,2)
        %set up first term
        movie_j = vj(:,movies_names(j));
        vjt = movie_j * movie_j';
        vj_sum = vj_sum + vjt;
        
        %set up second term
        miju = movie_ratings(j);
        Mvu = miju * movie_j;
        u2term = u2term + Mvu;
        
    end
    
    u1term = loi + vj_sum;
    
    ui(:,i) = u1term \ u2term;
end

%% Update Movie Location
disp('Updating Movie Location');

for j = 1 : num_movies
%j = 1;
    user_names = movie(j).user_id;
    user_ratings = movie(j).rating;
    
    ui_sum = 0;
    v2term = zeros(20,1);
    
    for i = 1 : size(user_names,2)
        %set up first term
        user_i = ui(:,user_names(i));
        uit = user_i * user_i'; % scalar value
        ui_sum = ui_sum + uit;
        
        %set up second term
        mijv = user_ratings(i);
        Mvv = mijv * user_i;
        v2term = v2term + Mvv;
        
    end
    
    v1term = loi + ui_sum;
    vj(:,j) = v1term \ v2term;
end

%% Check accuracy
disp('Getting RMSE');
total_size = 0;
squared_sum = 0;

like_m = 0;
for x = 1 : size(user,2)
%x = 1;
    x_rating = user(x).rating; %ratings for all the movies
    x_name = user(x).movie_id; %movie ids
    xsize = size(x_rating,2);
    for z = 1 : xsize % for each movie that the user has rated
        temp_rating = ui(:,z)' * vj(:,x_name(z));
        rounded_rating = round(temp_rating);
        actual_rating = x_rating(z);
        diff = rounded_rating - actual_rating;
        diffsq = diff^2;
        squared_sum = squared_sum + diffsq;
        
        % for likelihood
        like_m = like_m + ((1/(2*sigma)) * norm(actual_rating-temp_rating)^2);
    end
    total_size = total_size + xsize; % to do RMSE
end

big_fraction = squared_sum / total_size;
RMSE = sqrt(big_fraction);
RMSE_all(iter) = RMSE;


%% Get Log Likelihood
disp('Getting Log Likelihood');
like_u = 0; % second term in log likelihood
like_v = 0; % third term in log likelihood
for ii = 1 : size(ui,2)
    like_u = like_u + ((lambda/2) * norm(ui(:,ii))^2); 
end
for jj = 1 : size(vj,2)
    like_v = like_v + ((lambda/2) * norm(vj(:,jj))^2); 
end

likelihood_all(iter) = -like_m - like_u - like_v;
%% end iterating
end

%% Plot Stuff

figure;
plot(RMSE_all);
title('RMSE Over 100 Iterations');
xlabel('Iterations');
ylabel('RMSE Value');

figure;
plot(likelihood_all);
title('Log Likelihood Over 100 Iterations');
xlabel('Iterations');
ylabel('Likelihood Value');

save('processed.mat','ui','vj');
