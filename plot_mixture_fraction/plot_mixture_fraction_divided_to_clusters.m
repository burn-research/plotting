function [] = plot_mixture_fraction_divided_to_clusters(T, Z, idx, np, colors, destination)
%{
This function plots mixture fraction vs. a variable of choice.
NOTE: It performs random sampling from the mixture fraction pool.

Inputs: ---

- T

    variable data vector.

- Z

    mixture fraction data vector.

- idx

    matrix of cluster division.

- np

    number of points for random sampling from the mixture fraction
    pool.

- colors

    matrix of colors for each cluster.

- destination

    plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_legend = 40;
marker_size = 2;
legend_labels = {};
k = max(idx);

figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);

for i = 1:1:k

    % Sample at random np points:
    T_Z_data = [Z(idx==i), T(idx==i)];
    T_Z_data_sampled = randperm(length(T_Z_data), np);

    % Plot data for i-th cluster:
    scatter(T_Z_data(T_Z_data_sampled,1), T_Z_data(T_Z_data_sampled,2), marker_size, colors(i, :), 'o', 'filled'); hold on;

    % Append to legend:
    legend_labels{i} = ['Cluster $k_', num2str(i), '$'];

end
set(gca, 'FontSize', fontsize_axes);
box on, grid on

yticks([0 500 1000 1500 2000])

[l, hobj, hout, mout] = legend(legend_labels, 'Location', 'northeast', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', 25);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')
hold off

xlabel(['Z [-]'], 'FontSize', fontsize_label), ylabel(['T [K]'], 'FontSize', fontsize_label);

% Save plot:
print(gcf, [destination, 'mixture_fraction_temperature'], '-dpng', '-r300');
