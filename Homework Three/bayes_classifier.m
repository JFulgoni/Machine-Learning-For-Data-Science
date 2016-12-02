function [ aug_w ] = bayes_classifier( Xtrain, labeltrain)
%bayes classifier
%returns augmented w for the sake of testing 

index_1 = find(labeltrain==1);
index_0 = find(labeltrain==-1);
X1 = Xtrain(:,index_1);
X0 = Xtrain(:,index_0);

mu1 = mean(X1,2); % mean of each column
mu0 = mean(X0,2);

smu = mean(Xtrain,2); % shared mean for the whole matrix

s_cov = zeros(9);

for i = 1 : size(Xtrain,2)
    c = Xtrain(2:end,i) - smu(2:end);
    cc = c * c';
    s_cov = s_cov + cc;
end
s_cov = s_cov ./ 500;

pi1 = size(X1,2); % fraction of occurrences
pi0 = size(X0,2); % fraction of occurrences

clip_mu1 = mu1(2:end);
clip_mu0 = mu0(2:end);

% solve for w0
add_means = (clip_mu1 + clip_mu0);
sub_means = (clip_mu1 - clip_mu0);

first = log(pi1/pi0);
second = (((0.5 * add_means') / s_cov) * sub_means);

w0 = first - second; % done with w0

% solve for w term
w_term = s_cov \ sub_means;

aug_w = [w0;w_term]; % merge into a 10x1 vector

end

