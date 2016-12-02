% John Fulgoni
% Homework 4
% Problem 2 - Matrix Factorization - Kmeans portion
% Due 14 April 2015

clc;
clear;
close all;

load('processed.mat');
load('movie_ratings.mat');

k = 30; % number of classes

[ind, C] = kmeans(ui',k);

cluster_set = [5, 10, 15, 25, 30]; %they'll be different every time

for i = 1 : 5
movie_c = zeros(10,1);
movie_d = zeros(10,1);

for q = 1 : 10
    movie_c(q) = -1;
    movie_d(q) = 100;
end

clust_num = cluster_set(i);
cluster = C(clust_num,:);
films = find(ind==clust_num);

for j = 1 : size(films,1)
    other_movie = vj(:,films(j));
    diff = norm(other_movie' - cluster);
    
        if(diff < movie_d(10))
            movie_d(10) = diff;
            movie_c(10) = films(j);
        end
        if(diff < movie_d(9))
            movie_d(10) = movie_d(9);
            movie_c(10) = movie_c(9);
            movie_d(9) = diff;
            movie_c(9) = films(j);
        end
        if(diff < movie_d(8))
            movie_d(9) = movie_d(8);
            movie_c(9) = movie_c(8);
            movie_d(8) = diff;
            movie_c(8) = films(j);
        end
        if(diff < movie_d(7))
            movie_d(8) = movie_d(7);
            movie_c(8) = movie_c(7);
            movie_d(7) = diff;
            movie_c(7) = films(j);
        end
        if(diff < movie_d(6))
            movie_d(7) = movie_d(6);
            movie_c(7) = movie_c(6);
            movie_d(6) = diff;
            movie_c(6) = films(j);
        end
        if(diff < movie_d(5))
            movie_d(6) = movie_d(5);
            movie_c(6) = movie_c(5);
            movie_d(5) = diff;
            movie_c(5) = films(j);
        end
        if(diff < movie_d(4))
            movie_d(5) = movie_d(4);
            movie_c(5) = movie_c(4);
            movie_d(4) = diff;
            movie_c(4) = films(j);
        end
        if(diff < movie_d(3))
            movie_d(4) = movie_d(3);
            movie_c(4) = movie_c(3);
            movie_d(3) = diff;
            movie_c(3) = films(j);
        end
        if(diff < movie_d(2))
            movie_d(3) = movie_d(2);
            movie_c(3) = movie_c(2);
            movie_d(2) = diff;
            movie_c(2) = films(j);
        end
        if(diff < movie_d(1))
            movie_d(2) = movie_d(1);
            movie_c(2) = movie_c(1);
            movie_d(1) = diff;
            movie_c(1) = films(j);
        end
end

disp('.');
for q = 1 : 10
    disp(movie_names{movie_c(q)});
end
disp(' ');
end
