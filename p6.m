% Load the data
load moore.dat

% Extract the columns of interest
x = moore(:, 1);
y = moore(:, 2);

% Transform transistor values from exponential to linear
w = log(y);

% Create a matrix with ones on the left and data values on the right
X = [ones(size(x)), x];

% Perform linear regression to estimate the coefficients
[B_hat, ~, ~, ~, STATS] = regress(w, X);
w_hat = X * B_hat;

% Plot the original data and the linear regression model
figure
subplot(2,1,1)
plot(x, w, 'b', x, w_hat, 'r')
title("Moore's Law: Transistor Growth Over Time")
legend('Original Data', 'Linear Regression Model')

% Check if the difference between data (w) and model values (w_hat) follows a normal distribution
difference = w - w_hat;
subplot(2,1,2)
normplot(difference)
title('Normal Probability Plot of Residuals')

% Calculate R-squared value
R2 = STATS(1);

% Calculate the estimated number of transistors per unit area for the year 2025
transistors2025 = exp(B_hat(1) + B_hat(2) * 2025);
fprintf('Estimated number of transistors in 2025: %d\n', round(transistors2025))
fprintf('R-squared value: %.4f\n', R2)
