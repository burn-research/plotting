function [] = plot_mixture_fraction_vs_variable(var, Z, var_name, y_label_text, Z_stoich, destination)
%{
This function plots a scatter plot of mixture fraction vs. a variable of choice.
NOTE: It performs random sampling from the mixture fraction pool.

Inputs: ---

- variable

      variable data vector.

- Z

      mixture fraction data vector.

- destination

      plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
marker_size = 100;
linewidth = 6;
np = 10000;

% Sample at random np points:
var_Z = [Z, var];
var_Z_sampled = randperm(length(var_Z), np);

%% Plot:
figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]); 
scatter(var_Z(var_Z_sampled, 1), var_Z(var_Z_sampled, 2), marker_size, 'k', '.'); hold on
plot([Z_stoich, Z_stoich], [min(var), max(var)], '--', 'color', 'r', 'LineWidth', linewidth)
set(gca, 'FontSize', fontsize_axes); box on; grid on
xlabel(['Z [-]'], 'FontSize', fontsize_label)
ylabel(y_label_text, 'FontSize', fontsize_label)
xlim([-0.02, 1.02])
ylim([1.05*min(var), 1.05*max(var)])

% Save plot:
filename = [destination, 'variable_vs_mixture_fraction.png'];
saveas(gcf, filename, 'png');

