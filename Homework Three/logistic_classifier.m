function [ omegai ] = logistic_classifier( Xtrain, labeltrain )
%logistic classifier
%returns classifer created by stepping

omegai = zeros(10,1);
p = 0.1;


for i = 1 : size(Xtrain,2)
    xi = Xtrain(:,i);
    yi = labeltrain(i);
    
    % w has to be some sort of 1 x 10 vector right?
    expterm = -1 * yi * xi' * omegai;
    
    sigma = 1 / (1 + exp(expterm));
    
    step_term = p * (1 - sigma) * yi * xi;
    
    omegai = omegai + step_term;
end


end

