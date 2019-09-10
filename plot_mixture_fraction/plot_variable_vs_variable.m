function [] = plot_variable_vs_variable(var1, var2, var1_name, var2_name, destination)
%{
This function plots a scatter plot of a variable of choice vs. another variable of choice.
NOTE: It performs random sampling from the variable pool.

Inputs: ---

- var1

      first variable data vector.

- var1

      second variable data vector.

- var1_name

      name of the first variable.

- var2_name

      name of the second variable.

- destination

      plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
marker_size = 10;
np = 50000;

% Sample at random np points:
var_Z = [var1, var2];
var_Z_sampled = randperm(length(var_Z), np);

%% Plot:
figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]); 
scatter(var_Z(var_Z_sampled, 1), var_Z(var_Z_sampled, 2), marker_size, 'k', '.');
set(gca, 'FontSize', fontsize_axes); box on; grid on
xlabel([var1_name, ' [-]'], 'FontSize', fontsize_label)
ylabel([var2_name, ' [-]'], 'FontSize', fontsize_label)
xlim([min(var1), max(var1)])
ylim([min(var2), max(var2)])

% Save plot:
filename = [destination, var1_name, '_vs_', var2_name,'.png'];
saveas(gcf, filename, 'png');

