function [] = plot_color_clusters_with_variables(mesh_x, mesh_y, idx, var, var_name, no_cluster, destination)
% This function is used to colour the particular cluster with a variable 
% of choice.
%
% NOTE: Vectors mesh_x, mesh_y, idx and var must be of the same size.
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
%       vector of mesh points colors.
%
% - var
%
%       vector of variable data to color the idx.
%
% - var_name
%
%       string with this variable's name.
%
% - no_cluster
%
%       selected cluster number to plot.
%
% - destination
%
%       plot saving destination.

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_colorbar = 44;

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);
scatter(mesh_x(idx==no_cluster), mesh_y(idx==no_cluster), 3, var(idx==no_cluster), 'filled');
set(gca, 'FontSize', fontsize_axes);
xlim([min(mesh_x), max(mesh_x)]), ylim([min(mesh_y), max(mesh_y)]);
xlabel(['x'], 'FontSize', fontsize_label), ylabel(['y'], 'FontSize', fontsize_label);
xticks(0:5:max(mesh_x)), yticks([0:2:max(mesh_y)]);
box on

colormap jet
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';
% cb.Ruler.Exponent = -3;
caxis([min(var) max(var)]);

% Save plot:
filename = [destination, 'cluster_', num2str(no_cluster), '_coloured_with_variable_', var_name, '.eps'];
saveas(gcf, filename, 'epsc');

end

