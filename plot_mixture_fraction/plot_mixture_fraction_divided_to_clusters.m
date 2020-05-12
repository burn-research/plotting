function [] = plot_mixture_fraction_divided_to_clusters(T, Z, idx, np, y_label_text, destination)
% This function plots mixture fraction vs. a variable of choice.
% NOTE: It performs random sampling from the mixture fraction pool to avoid plotting large number of points.
%
% Inputs: ---
%
% - T
%     variable data vector.
%
% - Z
%     mixture fraction data vector.
%
% - idx
%     matrix of cluster division.
%
% - np
%     number of points for random sampling from the mixture fraction
%     pool. This is done to avoid plotting a large number of points.
%     If set to 0, all points will be plotted.
%
% - destination
%     plot saving destination.


%% Plotting parameters:
fontsize_axes = 35;
fontsize_label = 54;
fontsize_legend = 50;
marker_size = 50;
legend_labels = {};
k = max(idx);
colors = colormap(parula(k));

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);

for i = 1:1:k

    % Sample at random np points:
    T_Z_data = [Z(idx==i), T(idx==i)];
    if np == 0
        scatter(T_Z_data(:,1), T_Z_data(:,2), marker_size, colors(i, :), 'o', 'filled'); hold on;
    else
        T_Z_data_sampled = randperm(length(T_Z_data), np);
        scatter(T_Z_data(T_Z_data_sampled,1), T_Z_data(T_Z_data_sampled,2), marker_size, colors(i, :), 'o', 'filled'); hold on;
    end

    % Append to legend:
    legend_labels{i} = ['Cluster $k_{', num2str(i), '}$'];

end

set(gca, 'FontSize', fontsize_axes);
yticks([0, 500, 1000, 1500, 2000, 2500])
ylim([0, 2500])
box on, grid on

[l, hobj, hout, mout] = legend(legend_labels, 'Location', 'northeast', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', 25);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')

xlabel(['Mixture fraction [-]'], 'FontSize', fontsize_label), ylabel([y_label_text], 'FontSize', fontsize_label);
hold off

% Save plot:
print(gcf, [destination], '-dpng', '-r300');
