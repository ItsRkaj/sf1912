%% Problem 3: Konfidensintervall for Rayleighfordelning
load wave_data.mat
subplot(2,1,1), plot(y(1:end))
subplot(2,1,2), hist_density(y)

hold on     % Gor sa att ploten halls kvar
plot(lower_bound, 0, 'g*')
plot(upper_bound, 0, 'g*')

plot(0:0.1:6, raylpdf(0:0.1:6, my_est), 'r')
hold off