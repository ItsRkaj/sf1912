%% Problem 3: Konfidensintervall for Rayleighfordelning
load wave_data.mat
subplot(2,1,1), plot(y(1:end))
subplot(2,1,2), hist_density(y)

ybar = mean(y);
alpha = 0.05;
my_est = ybar/sqrt(pi/2);
D = sqrt((2 * ybar.^2 * (4 - pi) / (pi.^2 * M)));
critical_value = norminv(1 - alpha/2);
lower_bound = my_est - D * critical_value;
upper_bound = my_est + D * critical_value;

hold on % Gor sa att ploten halls kvar
plot(lower_bound, 0, 'g*')
plot(upper_bound, 0, 'g*')

plot(0:0.1:6, raylpdf(0:0.1:6, my_est), 'r')
hold off