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

% % Cross varidation (train: 80%, test: 20%)
cv = cvpartition(size(featureValuesL12345,1),'HoldOut',0.2);
featureValuesL12345_train = featureValuesL12345(cv.training,:);
passingValuesL12345_train = passingValuesL12345(cv.training);
featureValuesL12345_test = featureValuesL12345(cv.test,:);
passingValuesL12345_test = passingValuesL12345(cv.test);

%% 2. normalize data (features)
[featureValuesNorm_train, mu, sigdev] = zscore(featureValuesL12345_train,0);  %normalizes the columns
Mu_passingvalue = mean(passingValuesL12345_train);
passingValuesNorm_train = passingValuesL12345_train - Mu_passingvalue;

featureValuesNorm_test = (featureValuesL12345_test - mu)./sigdev;%normalize(featureValuesL1_test,2);  %normalizes the columns
passingValuesNorm_test = passingValuesL12345_test - Mu_passingvalue;

%% 3. Minimax solution
options = optimoptions('linprog','Algorithm','interior-point-legacy','Display','off','ConstraintTolerance', 1e-3, 'MaxIterations',1000);
mdlMM = linprog_chebyshev(featureValuesNorm_train,passingValuesNorm_train,options);

aT = horzcat(featureValuesNorm_test, ones(size(featureValuesNorm_test,1),1)); % adding 1 feature for intersect
predMM = aT * mdlMM.x;
diffMM = passingValuesNorm_test - predMM;

figure;
hist(diffMM,100);
grid minor;
ylabel('Number of cases');
xlabel('Measured - Prediction');
title('Minimax Model');
xlim([-10 10]);


%% 4. LSE solution
mdlLSE = fitlm(featureValuesNorm_train,passingValuesNorm_train);

predLSE = predict(mdlLSE,featureValuesNorm_test);
diffLSE = passingValuesNorm_test - predLSE;

figure;
hist(diffLSE,100);
grid minor;
ylabel('Number of cases');
xlabel('Measured - Prediction');
title('Least-Squares Model');
xlim([-10 10]);
