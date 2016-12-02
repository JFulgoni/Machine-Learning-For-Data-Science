function [ dwc, likelihood ] = h2_gradient(Xtrain21, label_train, wc)


%% evaluate gradient

% only for the first iteration of the overall algorithm
%wc = zeros(21,10);

%I think this becomes zero every time to start
dwc = zeros(21,10);

likelihood = zeros(10,1);

for n = 1 : size(Xtrain21,2);
    denom = 0;
    %evaluate denominator
    entry = Xtrain21(:,n)'; % this is transposed
    
    for j = 1 : 10
        denom = denom + exp(entry * wc(:,j));
    end
    
    class = label_train(n) + 1; % plus one for indices
    
    numer = entry * exp(entry * wc(:,class));
           %right now it's wi
    
    fract = numer / denom;
    
    xt = entry - fract;
    
    %{
    if n == 2;
       % disp(numer);
        %disp(denom);
        disp(fract);
        disp(entry);
        disp(xt);
    end
    %}
    
    dwc(:,class) = dwc(:,class) + xt'; %transpose it back to a column
    
    
    
    % likelihood
    xw = entry * wc(:,class);
    lk = xw - log(denom);
    likelihood(class) = likelihood(class) + lk;
end

