% Linac 1, 2, 3, 4, 5
% use Chebyshev's solution to solve minimax problem

%% 1. load features and passing rates for Linac 1,2,3,4,5
clear all;
load('../data/data_imrt_QA');

featureValues = cell2mat(mapcheck_features(2:end,2:end));
featureNames = mapcheck_features(1,2:end);
passingValues = cell2mat(passing_rates_all(2:end,1)); % 3%/3mm

%get Linac 1,2,3,4,5 measurements
L12345 = cell2mat(mapcheck_features(2:end,73:77));
L12345 = sum(L12345,2);

id_no_linac = L12345 == 0;
featureValuesL12345 = featureValues(~id_no_linac,:);
passingValuesL12345 = passingValues(~id_no_linac,:);

%% 2. normalize data (features)
[featureValuesNorm, mu, sigdev] = zscore(featureValuesL12345,0);  %normalizes the columns
Mu_passingvalue = mean(passingValuesL12345);
passingValuesNorm = passingValuesL12345 - Mu_passingvalue;

%% 3. Minimax solution
options = optimoptions('linprog','Algorithm','interior-point-legacy','Display','off','ConstraintTolerance', 1e-3, 'MaxIterations',1000);
mdl = linprog_chebyshev(featureValuesNorm,passingValuesNorm,options);

predMM = mdl.aT * mdl.x;
diffMM = passingValuesNorm - predMM;

figure;
hist(diffMM,100);
grid minor;
ylabel('Number of cases');
xlabel('Measured - Prediction');
title('Minimax Model');

%% 4. LSE solution
mdl = fitlm(featureValuesNorm,passingValuesNorm);

predLSE = predict(mdl,featureValuesNorm);
diffLSE = passingValuesNorm - predLSE;

figure;
hist(diffLSE,100);
grid minor;
ylabel('Number of cases');
xlabel('Measured - Prediction');
title('Least-Squares Model');

%% 5. get features