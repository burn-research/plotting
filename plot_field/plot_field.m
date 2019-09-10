function [] = plot_field(mesh_x, mesh_y, variable, destination)
%{
This function is used to plot a field of a scalar variable.

NOTE: Vectors mesh_x, mesh_y and variable must be of the same size.

Inputs: ---

- mesh_x

      x-coordinates.

- mesh_y

      y-coordinates.

- variable

      scalar variable vector.

- destination

      plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_colorbar = 44;

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);
scatter(mesh_x, mesh_y, 3, variable, 'filled');
set(gca, 'FontSize', fontsize_axes);
xlim([min(mesh_x), max(mesh_x)]), ylim([min(mesh_y), max(mesh_y)]);
xlabel(['x'], 'FontSize', fontsize_label), ylabel(['y'], 'FontSize', fontsize_label);
xticks(0:5:max(mesh_x)), yticks([0:2:max(mesh_y)]);
box on

colormap jet
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';
set(cb, 'YTick', [ceil(min(variable)*10)/10:0.1:floor(max(variable)*10)/10])
% cb.Ruler.Exponent = -3;
caxis([min(variable) max(variable)]);

% Save plot:
filename = [destination, 'field.eps'];
saveas(gcf, filename, 'epsc');

end
