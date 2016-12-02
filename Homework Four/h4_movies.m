% John Fulgoni
% Homework 4
% Problem 2 - Matrix Factorization - Movies
% Due 14 April 2015

clc;
clear;
close all;

load('processed.mat');
load('movie_ratings.mat');

%% Pulp Fiction
% movies about a chase?

pulp = vj(:,1219);

pulp_c = zeros(5,1);
pulp_d = zeros(5,1);

for q = 1 : 5
    pulp_c(q) = -1;
    pulp_d(q) = 100;
end

for q = 1 : size(vj,2) % for each movie in the set
    if(q ~= 1219) % not counting goofy movie
        other_movie = vj(:,q);
        diff = norm(other_movie-pulp);
        %disp(diff);
        
        if(diff < pulp_d(5))
            pulp_d(5) = diff;
            pulp_c(5) = q;
        end
        if(diff < pulp_d(4))
            pulp_d(5) = pulp_d(4);
            pulp_c(5) = pulp_c(4);
            pulp_d(4) = diff;
            pulp_c(4) = q;
        end
        if(diff < pulp_d(3))
            pulp_d(4) = pulp_d(3);
            pulp_c(4) = pulp_c(3);
            pulp_d(3) = diff;
            pulp_c(3) = q;
        end
        if(diff < pulp_d(2))
            pulp_d(3) = pulp_d(2);
            pulp_c(3) = pulp_c(2);
            pulp_d(2) = diff;
            pulp_c(2) = q;
        end
        if(diff < pulp_d(1))
            pulp_d(2) = pulp_d(1);
            pulp_c(2) = pulp_c(1);
            pulp_d(1) = diff;
            pulp_c(1) = q;
        end
    end
end

disp('Closest Movies to Pulp Fiction:');
for q = 1 : 5
    disp(movie_names{pulp_c(q)});
end
%what the hell
disp(' ');
%% Jurassic Park
%ok, they're basically all action movies

jurassic = vj(:,82);

jurassic_c = zeros(5,1);
jurassic_d = zeros(5,1);

for q = 1 : 5
    jurassic_c(q) = -1;
    jurassic_d(q) = 100;
end

for q = 1 : size(vj,2) % for each movie in the set
    if(q ~= 82) % not counting goofy movie
        other_movie = vj(:,q);
        diff = norm(other_movie-jurassic);
        %disp(diff);
        
        if(diff < jurassic_d(5))
            jurassic_d(5) = diff;
            jurassic_c(5) = q;
        end
        if(diff < jurassic_d(4))
            jurassic_d(5) = jurassic_d(4);
            jurassic_c(5) = jurassic_c(4);
            jurassic_d(4) = diff;
            jurassic_c(4) = q;
        end
        if(diff < jurassic_d(3))
            jurassic_d(4) = jurassic_d(3);
            jurassic_c(4) = jurassic_c(3);
            jurassic_d(3) = diff;
            jurassic_c(3) = q;
        end
        if(diff < jurassic_d(2))
            jurassic_d(3) = jurassic_d(2);
            jurassic_c(3) = jurassic_c(2);
            jurassic_d(2) = diff;
            jurassic_c(2) = q;
        end
        if(diff < jurassic_d(1))
            jurassic_d(2) = jurassic_d(1);
            jurassic_c(2) = jurassic_c(1);
            jurassic_d(1) = diff;
            jurassic_c(1) = q;
        end
    end
end

disp('Closest Movies to Jurassic Park:');
for q = 1 : 5
    disp(movie_names{jurassic_c(q)});
    disp(jurassic_d(q));
end
disp(' ');
%% Angels in the Outfield

angels = vj(:,623);

angels_c = zeros(5,1);
angels_d = zeros(5,1);

for q = 1 : 5
    angels_c(q) = -1;
    angels_d(q) = 100;
end


for q = 1 : size(vj,2) % for each movie in the set
    if(q ~= 623) % not counting goofy movie
        other_movie = vj(:,q);
        diff = norm(other_movie-angels);
        
        if(diff < angels_d(5))
            angels_d(5) = diff;
            angels_c(5) = q;
        end
        if(diff < angels_d(4))
            angels_d(5) = angels_d(4);
            angels_c(5) = angels_c(4);
            angels_d(4) = diff;
            angels_c(4) = q;
        end
        if(diff < angels_d(3))
            angels_d(4) = angels_d(3);
            angels_c(4) = angels_c(3);
            angels_d(3) = diff;
            angels_c(3) = q;
        end
        if(diff < angels_d(2))
            angels_d(3) = angels_d(2);
            angels_c(3) = angels_c(2);
            angels_d(2) = diff;
            angels_c(2) = q;
        end
        if(diff < angels_d(1))
            angels_d(2) = angels_d(1);
            angels_c(2) = angels_c(1);
            angels_d(1) = diff;
            angels_c(1) = q;
        end
    end
end

disp('Closest Movies to Angels in the Outfield:');
for q = 1 : 5
    disp(movie_names{angels_c(q)});
end
disp(' ');

save('three_movies.mat','pulp_c','pulp_d','jurassic_c','jurassic_d','angels_c','angels_d');

%% Save to cell

pulpcell = cell(5,2);
juracell = cell(5,2);
angelcell = cell(5,2);

for i = 1 : 5
    pulpcell{i,1} = movie_names{pulp_c(i)};
    juracell{i,1} = movie_names{jurassic_c(i)};
    angelcell{i,1} = movie_names{angels_c(i)};
    pulpcell{i,2} = num2str(pulp_d(i));
    juracell{i,2} = num2str(jurassic_d(i));
    angelcell{i,2} = num2str(angels_d(i));
end

matrix2latex(angelcell,'store.txt');