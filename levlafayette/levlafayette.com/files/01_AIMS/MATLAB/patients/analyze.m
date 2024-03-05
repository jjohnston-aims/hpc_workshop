% script analyze.m

patient_data = csvread('inflammation-01.csv');

disp(['Maximum inflammation: ', num2str(max(patient_data(:)))]);
disp(['Minimum inflammation: ', num2str(min(patient_data(:)))]);
disp(['Standard deviation: ', num2str(std(patient_data(:)))]);

ave_inflammation = mean(patient_data, 1);

# You're submitting a job on a cluster!
figure('visible', 'off')

ave_inflammation = mean(patient_data, 1);
plot(ave_inflammation);

% save plot to disk as png image:
print ('ave_inflammation','-dpng')

plot(max(patient_data, [], 1));
title('Maximum inflammation per day');

% save plot to disk as png image:
print ('Max_inflammation','-dpng')

plot(min(patient_data, [], 1));
title('Minimum inflammation per day');

% save plot to disk as png image:
print ('Min_inflammation','-dpng')

subplot(1, 3, 1);
plot(ave_inflammation);
ylabel('average')

subplot(1, 3, 2);
plot(max(patient_data, [], 1));
ylabel('max')

subplot(1, 3, 3);
plot(min(patient_data, [], 1));
ylabel('min')

% save plot to disk as png image:
print ('patient_data-01','-dpng')

close()

