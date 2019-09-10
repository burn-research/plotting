function [] = plot_color_manifold_with_clusters_color_map(X, Y, idx, destination)
% This function colours a 2D manifold with a prescribed colormap.
%
% Inputs: ---
%
% - X
%
%       x-variable.
%
% - Y
%
%       y-variable.
%
% - idx
%
%       matrix of corresponding color map.
%
% - destination
%
%       plot saving destination.

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_legend = 40;
linewidth = 1.5;

k = max(idx);

figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);

for i = 1:1:k
    scatter(X(idx==i), Y(idx==i), 2, idx(idx==i), 'filled'); hold on
    legend_labels{i} = ['Cluster $k_', num2str(i), '$'];
end

set(gca, 'FontSize', fontsize_axes);
box on, grid on
xlim([0, 1]), ylim([min(Y), 2100]);
xlabel(['Mixture fraction [-]'], 'FontSize', fontsize_label), ylabel(['Temperature [K]'], 'FontSize', fontsize_label);
xticks(0:0.2:1)
colormap(parula(k));

[l, hobj, hout, mout] = legend(legend_labels, 'Location', 'northeast', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', 25);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')
hold off

% Save plot:
filename = [destination, 'cluster_colored_manifold.png'];
saveas(gcf, filename, 'png');

end
