function [] = plot_clusters_color_map_3d(x, y, z, x_name, y_name, z_name, idx, camera_view, destination)
% This function plots a color map for clusters division on a 3D scatter plot.
%
% Input:
% ------------
%
% - x
%         a variable on the x-axis.
%
% - y
%         a variable on the y-axis.
%
% - z
%         a variable on the z-axis.
%
% - x_name
%         label for the variable on the x-axis.
%
% - y_name
%         label for the variable on the y-axis.
%
% - z_name
%         label for the variable on the z-axis.
%
% - idx
%       matrix of mesh points division into clusters.
%
% - camera_view
%         view of the camera on the 3D plot.
%
% - destination
%         is a string specifying the plot saving destination.
%
%         Example: destination = 'PLOTS/'

%% plot_clusters_color_map_3d
% Plotting parameters:
marker_size = 5;
marker_size_legend = 15;
fontsize_axes = 22;
fontsize_label = 50;
fontsize_legend = 46;

k = length(unique(idx));

legend_labels = {};

figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 0.8]);

for i = 1:1:k

    scatter3(x(idx==i), y(idx==i), z(idx==i), marker_size, idx(idx==i), 'o', 'filled'), hold on
    
    % Append to legend:
    legend_labels{i} = ['Cluster $k_{', num2str(i), '}$'];

end

set(gca, 'FontSize', fontsize_axes)
xlabel([x_name], 'FontSize', fontsize_label)
ylabel([y_name], 'FontSize', fontsize_label)
zlabel([z_name], 'FontSize', fontsize_label)
grid on
if isempty(camera_view)
    view();
else
    view(camera_view);
end

[l, hobj, hout, mout] = legend(legend_labels, 'Location', 'northwest', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', marker_size_legend);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')

% Save plot:
filename = [destination, 'clusters_map_3d.png'];
saveas(gcf, filename, 'png');

end