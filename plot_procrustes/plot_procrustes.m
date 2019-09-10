function [] = plot_procrustes(man_1_x, man_1_y, man_2_x, man_2_y, legend_labels, destination)
%{
This function plots a scatter plot of two manifolds matched together, e.g. by Procrustes analysis.

Inputs:

- man_1_x

        first manifold - quantity on the x-axis.

- man_1_y

        first manifold - quantity on the y-axis.

- man_2_x

        second manifold - quantity on the x-axis.

- man_2_y

        second manifold - quantity on the y-axis.


- legend_labels

        labels for the legend.

- destination

        plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_legend = 44;
marker_size = 5;
color_procrustes = [255,111,89]./256;

%% Plot:
figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);
grid on, box on,
scatter(man_1_x, man_1_y, marker_size, 'k', 'filled'); hold on
scatter(man_2_x, man_2_y, marker_size, color_procrustes, 'filled');
set(gca, 'FontSize', fontsize_axes); box on; grid on
xlabel(['Code-1, PC-score-1 [-]'], 'FontSize', fontsize_label)
ylabel(['Code-2, PC-score-2 [-]'], 'FontSize', fontsize_label)

[l, hobj, hout, mout] = legend(legend_labels, 'Location', 'northeast', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', 25);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')

% Save plot:
filename = [destination, '_procrustes.png'];
saveas(gcf, filename, 'png');

end
