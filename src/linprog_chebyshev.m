function result = linprog_chebyshev(features,outcomes,options)
    b =  outcomes;   
    aT = horzcat(features, ones(size(features,1),1)); % adding 1 feature for intersect

    % define feature names, add identy
    s = size(features,2);

    f = zeros(s+2,1);
    f(s+1) = 0;
    f(s+2) = 1; %setting up the last number equal to one so that it only minimizes t

    % Setting up the matrix for innequalities
    A = [[aT,-1.*ones(size(aT,1),1)]; [-aT,-1.*ones(size(aT,1),1)]];
    b = [b;-b];

    % check options for regularization
    x = linprog(f,A,b,[],[],[],[],[],options);

    result.aT = aT;
    result.x = x(1:end-1);
end