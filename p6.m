% Load the data
load moore.dat

% Extract the columns of interest
year = moore(:, 1);
nbr_of_transistors = moore(:, 2);

% Transform transistor values from exponential to linear
w = log(nbr_of_transistors);

% Create a matrix with ones on the left and data values on the right
X = [ones(size(year)), year];

% Perform linear regression to estimate the coefficients
[B_hat, ~, ~, ~, STATS] = regress(w, X);
y_pred = X * B_hat;

% Plot the original data and the linear regression model
figure
subplot(3,1,1)
plot(year, w, 'b', year, y_pred, 'r')
title("Moore's Law: Transistor Growth Over Time")
legend('Original Data', 'Linear Regression Model')

% Check if the difference between data (w) and model values (y_pred) follows a normal distribution
res = w - y_pred;

subplot(3,1,2), normplot(res)
subplot(3,1,3), histogram(res)

title('Normal Probability Plot of Residuals')

% Calculate R-squared value
R2 = STATS(1);

% Calculate the estimated number of transistors per unit area for the year 2025
transistors2025 = exp(B_hat(1) + B_hat(2) * 2025);
fprintf('Estimated number of transistors in 2025: %d\n', round(transistors2025))
fprintf('R-squared value: %.4f\n', R2)
