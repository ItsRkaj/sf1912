% Load the data
load birth.dat

% Extract the columns of interest
age = birth(:, 4);
height = birth(:, 16);
momsWeight = birth(:, 15);
childsWeight = birth(:, 3);

% Create a figure for normal probability plots

figure;

variables = {'Mother''s Age', 'Mother''s Height', 'Mother''s Weight', 'Child''s Weight'};
data = {age, height, momsWeight, childsWeight};

for i = 1:4
    subplot(2,2,i)
    normplot(data{i})
    title(variables{i})
end

% Set the significance level for the Jarque-Bera test
alpha = 0.05;

% Perform Jarque-Bera test for normality
ageJB = jbtest(age, alpha);
heightJB = jbtest(height, alpha);
momsWeightJB = jbtest(momsWeight, alpha);
childsWeightJB = jbtest(childsWeight, alpha);

fprintf('\nMother''s Age is Normally Distributed: %s\n', logicalString(ageJB))
fprintf('Mother''s Height is Normally Distributed: %s\n', logicalString(heightJB))
fprintf('Mother''s Weight is Normally Distributed: %s\n', logicalString(momsWeightJB))
fprintf('Child''s Weight is Normally Distributed: %s\n', logicalString(childsWeightJB))

function result = logicalString(value)
    if value == 1
        result = 'False';
    else
        result = 'True';
    end
end
