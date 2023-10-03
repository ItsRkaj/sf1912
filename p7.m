% Load birth data

% How mother's height affects children's weight, scatter plot
% Simple linear model, slight positive relationship
load birth.dat
motherHeight = birth(:,16);   % Mother's height
childWeight = birth(:,3);     % Child's weight

X = [ones(length(motherHeight), 1), motherHeight];
B_hat = regress(childWeight, X);
predictedChildWeight = X * B_hat;  % Estimate of child's weight

% Plot the above code
figure
scatter(motherHeight, childWeight)
hold on
plot(motherHeight, predictedChildWeight)

% Multiple linear regression model with all other variables
% Includes mother's weight, smoking habits, alcohol habits in relation to child's weight
motherWeight = birth(:,15);   % Mother's weight
smokesMother = birth(:,20) == 3;   % If the mother smokes
drinksMother = birth(:,26) == 2;  % If the mother drinks

childWeight2 = birth(:, 3);  % Child's weight

X2 = [ones(size(motherWeight)), motherWeight, smokesMother, drinksMother];
[B_coeffs, BINT, R] = regress(childWeight2, X2);
predictedChildWeight2 = X2 * B_coeffs;  % Estimate of child's weight

fprintf('Coefficients: %d \n', B_coeffs);
fprintf('Confidence intervals for coefficients: [%d, %d] \n', BINT(:,1), BINT(:,2));

% Residuals: actual - predicted values
figure
normplot(R)
