%% Problem 4: Fordelningar av givna data
load birth.dat
x = birth(birth(:, 25) == 1, 3); %X är barnens vikt för icke rökare, och dem som slutat
y = birth(birth(:, 25) == 3, 3);  %Y är barnens vikt för rökare

subplot(2,2,1), boxplot(x),
axis([0 2 500 5000])
subplot(2,2,2), boxplot(y),
axis([0 2 500 5000])

subplot(2,2,3:4), ksdensity(x),
hold on
[fy, ty] = ksdensity(y);
plot(ty, fy, 'r')
hold off