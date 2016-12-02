function [ fin ] = bayes(Xtest, mu, cov )
%does bayes to get the probability

% something isn't right
% need to normalize or something

%Xtest and mu are both 20x1 vectors
diff = (Xtest - mu);
mid = (((-0.5 .* diff') / cov) * diff);
% multiplying makes this extremely better

mid_e = exp(mid); % this value is consistently 0 or extremely low
 
cov_a = det(cov); % determinant?

cov_s = sqrt(cov_a);
fin = (0.1 / cov_s) * mid_e;

end

