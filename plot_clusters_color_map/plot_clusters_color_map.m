function [] = plot_clusters_color_map(mesh_x, mesh_y, idx, destination)
% This function plots a color map for clusters division.
%
% Inputs: ---
%
% - mesh_x
%
%       x-coordinates.
%
% - mesh_y
%
%       y-coordinates.
%
% - idx
%
%       matrix of mesh points division into clusters.
%
% - destination
%
%       plot saving destination.

%% Plotting parameters:
fontsize_axes = 32;
fontsize_label = 44;
fontsize_legend = 40;
fontsize_colorbar = 32;
text_size = 36;

k = max(idx);

cluster_range = 1:1:k;

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);
scatter(mesh_x, mesh_y, 1, idx, 'filled');
set(gca, 'FontSize', fontsize_axes);
xlim([min(mesh_x), max(mesh_x)]), ylim([min(mesh_y), max(mesh_y)]);
xlabel(['x'], 'FontSize', fontsize_label), ylabel(['y'], 'FontSize', fontsize_label);
xticks(0:10:max(mesh_x)), yticks([0:2:max(mesh_y)]);

colormap(parula(k));
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';
set(cb, 'ticks', (1+0.5*(k-1)/k):((k-1)/k):(k - 0.5*(k-1)/k), 'ticklabels', cluster_range);

% Save plot:
filename = [destination, 'clusters_map.eps'];
saveas(gcf, filename, 'epsc');

end